Message-Id: <200005170524.HAA30085@denx.local.net>
To: greyham@research.canon.com.au (Graham Stoney)
cc: t.shantha.laxmi@exgate.tek.com,
        linuxppc-embedded@lists.linuxppc.org (LinuxPPC Embedded Mailing List)
Subject: Re: crash loadin bash after booting linux on a MPC860ADS 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_18022156880"
Date: Wed, 17 May 2000 07:24:51 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multipart MIME message.

--==_Exmh_18022156880
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 17 May 2000 09:55:53 +1000."
             <20000516235553.C15D13C962@elph.research.canon.com.au>
Content-Transfer-Encoding: 8bit

In message <20000516235553.C15D13C962@elph.research.canon.com.au>
Graham Stoney wrote:
>
> By the way, do any other list members know of any references on the 'net that
> give some PowerPC-specific tips to decoding oops messages?  If I can find
> something more applicable than Documentation/oops-tracing.txt, I'd like to
> include a link to it in the HOWTO.

Usually I'm using the little script  attached  below;  it  loads  the
kernel symbols from /LinuxPPC/usr/src/linux/System.map, or, if a file
name argument is given, from that file.

Feed it the "Call backtrace" messages on stdin:

	-> /backtrace System.map
	Reading symbols from System.map
	C0745300 C003255C C002FDD4 C002FE78 C00361E8 C00AD924 C006BDC8
	C006C814 C006C95C C006C9E8 C006CF00 C00ADA8C C00AD41C C00AD7FC
	C00AC5A0 C00A87E0 C00A8878 C0002670 C00075F4

and you will get:

	0xc0745300 -- 0xc00aeae8 + 0x696818   skb_init
	0xc003255c -- 0xc00324e8 + 0x0074   wakeup_bdflush
	0xc002fdd4 -- 0xc002fdb8 + 0x001c   balance_dirty
	0xc002fe78 -- 0xc002fe58 + 0x0020   mark_buffer_dirty
	0xc00361e8 -- 0xc0035dc0 + 0x0428   block_write
	0xc00ad924 -- 0xc00ad8e0 + 0x0044   flush_window
	0xc006bdc8 -- 0xc006b930 + 0x0498   inflate_codes
	0xc006c814 -- 0xc006c184 + 0x0690   inflate_dynamic
	0xc006c95c -- 0xc006c84c + 0x0110   inflate_block
	0xc006c9e8 -- 0xc006c998 + 0x0050   inflate
	0xc006cf00 -- 0xc006cb3c + 0x03c4   gunzip
	0xc00ada8c -- 0xc00ad9e0 + 0x00ac   crd_load
	0xc00ad41c -- 0xc00ad2a8 + 0x0174   rd_load_image
	0xc00ad7fc -- 0xc00ad7dc + 0x0020   initrd_load
	0xc00ac5a0 -- 0xc00ac56c + 0x0034   partition_setup
	0xc00a87e0 -- 0xc00a87b0 + 0x0030   do_initcalls
	0xc00a8878 -- 0xc00a87fc + 0x007c   do_basic_setup
	0xc0002670 -- 0xc000265c + 0x0014   init
	0xc00075f4 -- 0xc00075c8 + 0x002c   kernel_thread

Not perfect, but better than nothing.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Life would be so much easier if we could  just  look  at  the  source
code.                                                   -- Dave Olson


--==_Exmh_18022156880
Content-Type: text/plain ; name="backtrace"
Content-Description: backtrace
Content-Disposition: attachment; filename="backtrace"
Content-Transfer-Encoding: base64

IyEvdXNyL2Jpbi9wZXJsIC13CgpteSAkbWFwZmlsZSA9IHNoaWZ0IHx8ICcvTGludXhQUEMv
dXNyL3NyYy9saW51eC9TeXN0ZW0ubWFwJzsKCnByaW50IFNUREVSUiAiUmVhZGluZyBzeW1i
b2xzIGZyb20gJG1hcGZpbGVcbiI7CgojCiMgUmVhZCBzeW1ib2wgdGFibGUKIwpvcGVuIChN
QVAsICRtYXBmaWxlKSBvciBkaWUgIkNhbid0IG9wZW4gJG1hcGZpbGU6ICQhXG4iOwoKbXkg
JGNudCA9IDA7Cgp3aGlsZSAoPE1BUD4pIHsKCWNob21wOwoJbXkgKCRhLCR0LCRuKSA9IHNw
bGl0OwoJJGEgPSBldmFsICgnMHgnIC4gJGEpOwoJaWYgKCR0ID1+IC9edCQvaSkgewoJCSRh
ZGRyWyRjbnRdID0gJGE7CgkJJG5hbWVbJGNudF0gPSAkbjsKCQkrKyRjbnQ7Cgl9Cn0KY2xv
c2UgTUFQOwoKbXkgKCRpLCAkbiwgJGxhc3QpOwoKI2ZvciAoJGk9MDsgJGk8JGNudDsgKysk
aSkgewojCXByaW50ZiAiMHglMDh4ICAlc1xuIiwgJGFkZHJbJGldLCAkbmFtZVskaV07CiN9
CgojCiMgTm93IGdldCBiYWNrdHJhY2UgaW5mbyBmcm9tIHN0ZGluCiMKCndoaWxlICg8Pikg
ewoJY2hvbXA7CglteSBAYSA9IHNwbGl0OwoJbXkgJGFhOwoKCWZvciAoJGk9MDsgJGk8PSQj
YTsgKyskaSkgewoJCSRhYSA9IGV2YWwgKCcweCcgLiAkYVskaV0pOwoKCQkkbGFzdCA9IC0x
OwoJCWZvciAoJG49MDsgJG48JGNudDsgKyskbikgewoJCQlpZiAoJGFkZHJbJG5dID4gJGFh
KSB7CgkJCQlsYXN0OwoJCQl9CgkJCSRsYXN0ID0gJG47CgkJfQoKCQlpZiAoJGxhc3QpIHsK
CQkJbXkgJG9mZnNldCA9ICRhYSAtICRhZGRyWyRsYXN0XTsKCgkJCXByaW50ZiAiMHglMDh4
IC0tIDB4JTA4eCArIDB4JTA0eCAgICVzXG4iLAoJCQkJJGFhLCAkYWRkclskbGFzdF0sICRv
ZmZzZXQsICRuYW1lWyRsYXN0XTsKCQl9IGVsc2UgewoJCQlwcmludGYgIjB4JTA4eCAtLSB1
bmtub3duIGFkZHJlc3NcbiIsICRpLCAkYWE7CgkJfQoJfQp9Cg==

--==_Exmh_18022156880--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
