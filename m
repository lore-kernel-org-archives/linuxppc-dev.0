Subject: Re: gcc version 2.95.3 20010315 (release/MontaVista) cross compiler
From: Guy Streeter <streeter@redhat.com>
To: "David C. Chiu" <dchiu@ariodata.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <8A098FDFC6EED94B872CA2033711F86F775A6F@orion.ariodata.com>
References: <8A098FDFC6EED94B872CA2033711F86F775A6F@orion.ariodata.com>
Content-Type: text/plain
Message-Id: <1071703053.1035.2.camel@jarjar.hsv.redhat.com>
Mime-Version: 1.0
Date: 17 Dec 2003 17:17:33 -0600
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 2003-12-17 at 17:02, David C. Chiu wrote:
> We're experiencing some unexpected behavior with binary generated with
> the said version of gcc; namely that variables declared to char appear
> to be defaulting to unsigned char.
>
> #include <stdio.h>
> #include <stdlib.h>
>
> int main( int argc, char** args, char** envs )
> {
>         char sc;
>         unsigned char uc;
>
>         sc = uc = -3;
>
>         printf( "signed char: %d unsigned char: %d\n", sc, uc );
>         if ( sc > (char)0 )
>                 printf( "sc is greater than zero\n" );
>         else
>                 printf( "sc is less or equal to zero\n" );
>
>         return 0;
> }
>
> The preceeding code would produce the following unexpected result --
>
> signed char: 253 unsigned char: 253
> sc is greater than zero
>
> Making the following change --
>
>         signed char sc;
>         unsigned char uc;
> 	.
> 	.
>
> Would produce the expected result --
>
> signed char: -3 unsigned char: 253
> sc is less or equal to zero
>
> Can someone shed some light on this? (As in, is this "normal" and we do
> not know only because we've been living under a rock ;-)

This behavior is indeed "normal". For some reason (compatibility with
AIX, I think) the gcc compiler for ppc has always made char unsigned by
default.
Try adding the -fsigned-char option to you gcc command line.

--Guy


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
