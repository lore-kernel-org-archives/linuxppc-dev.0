Return-Path: <pebolle@tiscali.nl>
Received: from cpsmtpb-ews02.kpnxchange.com (cpsmtpb-ews02.kpnxchange.com
 [213.75.39.5])
 by lists.ozlabs.org (Postfix) with ESMTP id 3B4BF1A0069
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Aug 2014 23:00:37 +1000 (EST)
Message-ID: <1409402838.21896.99.camel@x220>
Subject: Re: [PATCH 1/5] kexec: Fix make headers_check
From: Paul Bolle <pebolle@tiscali.nl>
To: Vivek Goyal <vgoyal@redhat.com>
Date: Sat, 30 Aug 2014 14:47:18 +0200
In-Reply-To: <20140825172234.GD14379@redhat.com>
References: <cover.1408731991.git.geoff@infradead.org>
 <115373b6ac68ee7a305975896e1c4971e8e51d4c.1408731991.git.geoff@infradead.org>
 <20140825172234.GD14379@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: maximilian attems <max@stro.at>, Geoff Levand <geoff@infradead.org>,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[Added Peter Anvin.]

On Mon, 2014-08-25 at 13:22 -0400, Vivek Goyal wrote:
> On Fri, Aug 22, 2014 at 06:39:47PM +0000, Geoff Levand wrote:
> > Remove the unneded declaration for a kexec_load() routine.
> > 
> > Fixes errors like these when running 'make headers_check':
> > 
> > include/uapi/linux/kexec.h: userspace cannot reference function or variable defined in the kernel
> > 
> > Signed-off-by: Geoff Levand <geoff@infradead.org>
> 
> I think Paul Bolle tried to remove this in the past and maximilian
> had objections.
> 
> http://lists.infradead.org/pipermail/kexec/2014-January/010902.html

I've wanted to resend my patch, perhaps with a new commit explanation,
for quite some time now. I never got around doing that.

> I can't see that how exporting kernel prototype helps here.

It doesn't, for the reasons I've set out in
http://lists.infradead.org/pipermail/kexec/2014-January/010900.html . In
short: why bother using this prototype if one still needs to define the
matching function oneself?

> kexec-tools
> seems to be using syscall(__NR_kexec_load) directly for non-xen case. So
> I would be fine with removing this definition. Just trying to make sure
> that it does not break any other library or users of this declaration.

Obviously, this can only break compiling those libraries, or other
users. It can't break already compiled binaries. Besides I don't think
those libraries, etc actually exist. Maximilian mentioned klibc in
January, but I wasn't able to find a version of klibc that cared about
this prototype. No one pointed me at a version that does (or any other
library, etc., for that matter).

(If we do decide to keep this prototype, we should special case this
prototype in headers_check.pl just to silence the build.)

The above can be summarized like this:
    Acked-by: Paul Bolle <pebolle@tiscali.nl>


Paul Bolle
