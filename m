Message-ID: <FA06AA2C99BCD511951200005A99441001E3ED51@irvexch1.sextantifs.com>
From: "Curtis, Allen" <Allen.Curtis@Thales-IFS.com>
To: "'Dan Malek'" <dan@embeddededge.com>,
	"Curtis, Allen" <Allen.Curtis@Thales-IFS.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Date: Wed, 28 Aug 2002 12:03:56 -0700
Subject: RE: 8260/8xx Embedded Boot patch
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>currently working without the ability to test everything else that may
>be affected.  You definitely have to take the "if it works,

They are not using this code, it was not working.

>> 2. If you assume that any platform that uses
>CONFIG_EMBEDDEDBOOT may want to
>> pass in a bd_info structure,
>
>We don't assume that at all.  In fact there are only three
>boards now where
>we make that assumption and it is clear in the code which ones
>they are.

You seem to have missed the part about putting the platform specific stuff
in embed_config.c. When you are starting up and you use documentation such
as Documentation/powerpc/SBC8260_memory_mapping.txt, which specifies that
the BIOS passes in bd_info structures, you assume that is what you should do
and then find out that it only works for specific boards.

This brings me back to my original suggestion, create kernel features with
specific behaviors that platform specific header files can enable. Keep the
kernel source free of platform conditional compiles with the exception of
files contained in the platform directory. In this case CONFIG_EMBEDDED
indicates that simple boot should be used and the bios may provide a bd_info
structure. It does not specify the structure or that a structure is required
but the provision has been made for it.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
