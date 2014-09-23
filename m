Return-Path: <rostedt@goodmis.org>
Received: from cdptpa-oedge-vip.email.rr.com
 (cdptpa-outbound-snat.email.rr.com [107.14.166.226])
 by lists.ozlabs.org (Postfix) with ESMTP id 78F2D1A007F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Sep 2014 09:46:07 +1000 (EST)
Date: Tue, 23 Sep 2014 19:46:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 3/3] powerpc/ftrace: simplify prepare_ftrace_return
Message-ID: <20140923194604.233bdbad@gandalf.local.home>
In-Reply-To: <1410937624-25140-3-git-send-email-anton@samba.org>
References: <1410937624-25140-1-git-send-email-anton@samba.org>
 <1410937624-25140-3-git-send-email-anton@samba.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/pKmPtJCdPki8awLJI3NPOZB"
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--MP_/pKmPtJCdPki8awLJI3NPOZB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wed, 17 Sep 2014 17:07:04 +1000
Anton Blanchard <anton@samba.org> wrote:

> Instead of passing in the stack address of the link register
> to be modified, just pass in the old value and return the
> new value and rely on ftrace_graph_caller to do the
> modification.
> 
> This removes the exception handling around the stack update -
> it isn't needed and we weren't consistent about it. Later on
> we would do an unprotected modification:
> 
>        if (!ftrace_graph_entry(&trace)) {
>                *parent = old;
> 

First I'll say this is something I've been wanting to do with x86 for
some time. That said...

With this patch, things move much further in my tests. The stress test
passes again. But then it fails on my stack trace test. Which is
because this is what I have in the stack traces:

           sleep-3557  [000] d...   100.206808: <stack trace>
 => 0
 => 0
 => 0
 => 0
 => 0
 => 0
 => 0
 => 0


Where without the patches I have something like this:

          sleep-3641  [001] d...   304.023550: <stack trace>
 => .ftrace_raw_event_sched_switch
 => .__schedule
 => .schedule
 => .do_nanosleep
 => .hrtimer_nanosleep
 => .compat_SyS_nanosleep
 => syscall_exit
 => 0

This could be broken from the earlier patches, I haven't run just this
test. I probably should on them.

I've attached the test.

-- Steve

--MP_/pKmPtJCdPki8awLJI3NPOZB
Content-Type: application/octet-stream; name=ftrace-test-event-stacktrace
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=ftrace-test-event-stacktrace

IyEvYmluL2Jhc2gKCmZpbmRfZGVidWdmcygpIHsKICAgIGRlYnVnZnM9YGNhdCAvcHJvYy9tb3Vu
dHMgfCB3aGlsZSByZWFkIG1vdW50IGRpciB0eXBlIG9wdHMgYSBiOyBkbwoJaWYgWyAkbW91bnQg
PT0gImRlYnVnZnMiIF07IHRoZW4KCSAgICBlY2hvICRkaXI7CgkgICAgYnJlYWsKCWZpCiAgICBk
b25lYAogICAgaWYgWyAteiAiJGRlYnVnZnMiIF07IHRoZW4KCWlmICEgbW91bnQgLXQgZGVidWdm
cyBub2RldiAvc3lzL2tlcm5lbC9kZWJ1ZzsgdGhlbgoJICAgIGVjaG8gIkZBSUxFRCB0byBtb3Vu
dCBkZWJ1Z2ZzIgoJICAgIGV4aXQgLTEKCWZpCgllY2hvICIvc3lzL2tlcm5lbC9kZWJ1ZyIKICAg
IGVsc2UKCWVjaG8gJGRlYnVnZnMKICAgIGZpCn0KCmRlYnVnZnM9YGZpbmRfZGVidWdmc2AKVFJB
Q0VESVI9IiRkZWJ1Z2ZzL3RyYWNpbmciCkVWRU5URElSPSRUUkFDRURJUi9ldmVudHMKRVZFTlQ9
JEVWRU5URElSL3NjaGVkL3NjaGVkX3N3aXRjaApFVkVOVF9FTkFCTEU9JEVWRU5UL2VuYWJsZQpU
UklHR0VSX0ZJTEU9JEVWRU5UL3RyaWdnZXIKVFJBQ0VfRklMRT0kVFJBQ0VESVIvdHJhY2UKVFJB
Q0lOR19PTj0kVFJBQ0VESVIvdHJhY2luZ19vbgoKIyBzZXQgLXgKCmlmIFsgISAtZiAkVFJJR0dF
Ul9GSUxFIF07IHRoZW4KICAgIGVjaG8gInRyaWdnZXJzIGFyZSBub3Qgc2V0IGZvciB0aGlzIGtl
cm5lbCIKICAgIGV4aXQgMApmaQoKZnVuY3Rpb24gY250X3RyYWNlKCkgewoJICAgIGdyZXAgLXYg
J14jJyAkVFJBQ0VfRklMRSB8IHdjIC1sCn0KCmZ1bmN0aW9uIGNsZWFyX3RyaWdnZXJzKCkgewog
ICAgZ3JlcCAtdiAnXiMnICRUUklHR0VSX0ZJTEUgfCB3aGlsZSByZWFkIHQ7IGRvCgl0cj1gZWNo
byAkdCB8IHNlZCAtZSBzJy86LiovLydgCglpZiBbICR0ciA9PSAiZW5hYmxlX2V2ZW50IiAtbyAk
dHIgPT0gImRpc2FibGVfZXZlbnQiIF07IHRoZW4KCSAgICB0cj1gZWNobyAkdCB8IHNlZCAtZSBz
Jy9cKFteOl0qOlteOl0qOlteOl0qXCk6LiovXDEvJ2AKCWZpCgllY2hvICIhJHRyIiA+ICRUUklH
R0VSX0ZJTEUKICAgIGRvbmUKfQoKZnVuY3Rpb24gY2hlY2tfZXZlbnRzKCkgewogICAgZXZlbnRz
PSQxCiAgICBzdGFjaz0kMgogICAgY291bnQ9JDMKCiAgICBpZiBbICRldmVudHMgLWVxIDEgXTsg
dGhlbgoJaWYgISBncmVwIC1xICdzY2hlZF9zd2l0Y2g6JyAkVFJBQ0VfRklMRSA7IHRoZW4KCSAg
ICBlY2hvICJFeHBlY3RlZCBldmVudCBidXQgaXQgd2Fzbid0IHRoZXJlIgoJICAgIGV4aXQgLTEK
CWZpCiAgICBlbHNlCglpZiBncmVwIC1xICdzY2hlZF9zd2l0Y2g6JyAkVFJBQ0VfRklMRSA7IHRo
ZW4KCSAgICBlY2hvICJFeHBlY3RlZCBubyBldmVudHMgYnV0IGV2ZW50cyB3ZXJlIGZvdW5kIgoJ
ICAgIGV4aXQgLTEKCWZpCiAgICBmaQoKICAgIGlmIFsgJHN0YWNrIC1lcSAxIF07IHRoZW4KCWlm
IFsgJGNvdW50IC1lcSAwIF07IHRoZW4KCSAgICAjIHVubGltaXRlZCwgZmluZCB0aGUgc2xlZXAg
Y2FsbAoJICAgIGlmICEgZ3JlcCAtcSAnXiA9PiAuKnNsZWVwJyAkVFJBQ0VfRklMRTsgdGhlbgoJ
CWVjaG8gIkNvdWxkIG5vdCBmaW5kIHNsZWVwIGNhbGwiCgkJZXhpdCAtMQoJICAgIGZpCgllbHNl
CgkgICAgIyBjb3VudCB0aGUgc3RhY2sgdHJhY2VzCgkgICAgY250PWBncmVwICc8c3RhY2sgdHJh
Y2U+JyAkVFJBQ0VfRklMRSB8IHdjIC1sYDsKCSAgICBpZiBbICRjbnQgLW5lICRjb3VudCBdOyB0
aGVuCgkJZWNobyAiRXhwZWN0ZWQgJGNvdW50IGhpdHMgYnV0IG9ubHkgc2VlICRjbnQiCgkJZXhp
dCAtMQoJICAgIGZpCglmaQogICAgZWxzZQoJaWYgZ3JlcCAtcSAnXiA9PicgJFRSQUNFX0ZJTEU7
IHRoZW4KCSAgICBlY2hvICJGb3VuZCBzdGFjayB0cmFjZSB3aGVuIG5vdCBlbmFibGVkIgoJICAg
IGV4aXQgLTEKCWZpCiAgICBmaQp9CgpmdW5jdGlvbiBkb19yZXNldCgpIHsKICAgIGNsZWFyX3Ry
aWdnZXJzCiAgICBlY2hvIG5vcCA+ICRUUkFDRURJUi9jdXJyZW50X3RyYWNlciB8fCBleGl0IC0x
CiAgICBlY2hvIDAgPiAkVFJBQ0VESVIvZXZlbnRzL2VuYWJsZSB8fCBleGl0IC0xCiAgICBlY2hv
ID4gJFRSQUNFX0ZJTEUgfHwgZXhpdCAtMQogICAgZWNobyAxID4gJFRSQUNJTkdfT04gfHwgZXhp
dCAtMQp9Cgojc2V0IC14CgplY2hvICcqKiBDTEVBUiBUUkFDRScKZG9fcmVzZXQKCiMgY2hlY2sg
c3RhY2t0cmFjZSBhdmFpbGFibGUKaWYgISBncmVwIC1xIHN0YWNrdHJhY2UgJFRSSUdHRVJfRklM
RTsgdGhlbgogICAgZWNobyAic3RhY2t0cmFjZSB0cmlnZ2VyIG5vdCBhdmFpbGFibGUiCiAgICBl
eGl0IDAKZmkKCmNudD1gY250X3RyYWNlYAppZiBbICRjbnQgLW5lIDAgXTsgdGhlbgogICAgZWNo
byAiRm91bmQganVuayBpbiB0cmFjZSBmaWxlLCBleGl0aW5nIgogICAgZXhpdCAtMQpmaQoKZWNo
byAiRW5hYmxlIG9ubHkgZXZlbnRzIgoKZWNobyAxID4gJEVWRU5UX0VOQUJMRQpzbGVlcCAxCmVj
aG8gMCA+ICRUUkFDSU5HX09OCgpjaGVja19ldmVudHMgMSAwIDAKZG9fcmVzZXQKCmVjaG8gIkVu
YWJsZSBvbmx5IHN0YWNrIHRyYWNlIgoKZWNobyAwID4gJFRSQUNJTkdfT04KZWNobyBzdGFja3Ry
YWNlID4gJFRSSUdHRVJfRklMRQoKZWNobyAxID4gJFRSQUNJTkdfT04Kc2xlZXAgMQplY2hvIDAg
PiAkVFJBQ0lOR19PTgoKY2hlY2tfZXZlbnRzIDAgMSAwCmRvX3Jlc2V0CgoKZWNobyAiRW5hYmxl
IGJvdGggc3RhY2sgdHJhY2UgYW5kIGV2ZW50cyIKCmVjaG8gMCA+ICRUUkFDSU5HX09OCmVjaG8g
c3RhY2t0cmFjZSA+ICRUUklHR0VSX0ZJTEUKZWNobyAxID4gJEVWRU5UX0VOQUJMRQoKZWNobyAx
ID4gJFRSQUNJTkdfT04Kc2xlZXAgMQplY2hvIDAgPiAkVFJBQ0lOR19PTgoKY2hlY2tfZXZlbnRz
IDEgMSAwCmRvX3Jlc2V0Cgpmb3IgaSBpbiAxIDIgMzsgZG8KICAgIGlmIFsgJGkgLWd0IDEgXTsg
dGhlbgoJcz0ncycKICAgIGVsc2UKCXM9JycKICAgIGZpCiAgICBlY2hvICJFbmFibGUgc3RhY2sg
dHJhY2Ugb25seSAkaSB0aW1lJHMiCgogICAgZWNobyAxID4gJFRSQUNJTkdfT04KICAgIGVjaG8g
c3RhY2t0cmFjZTokaSA+ICRUUklHR0VSX0ZJTEUKICAgIGVjaG8gMSA+ICRFVkVOVF9FTkFCTEUK
CiAgICBzbGVlcCAxCiAgICBlY2hvIDAgPiAkVFJBQ0lOR19PTgoKICAgIGNoZWNrX2V2ZW50cyAx
IDEgJGkKICAgIGRvX3Jlc2V0CmRvbmUKCgplY2hvICcqKiBTVUNDRVNTJwoKZXhpdCAwCg==

--MP_/pKmPtJCdPki8awLJI3NPOZB--
