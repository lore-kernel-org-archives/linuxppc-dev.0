Subject: gcc version 2.95.3 20010315 (release/MontaVista) cross compiler
Date: Wed, 17 Dec 2003 15:02:37 -0800
MIME-Version: 1.0
Message-ID: <8A098FDFC6EED94B872CA2033711F86F775A6F@orion.ariodata.com>
Content-Type: text/plain;
	charset="us-ascii"
From: "David C. Chiu" <dchiu@ariodata.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We're experiencing some unexpected behavior with binary generated with
the said version of gcc; namely that variables declared to char appear
to be defaulting to unsigned char.

#include <stdio.h>
#include <stdlib.h>

int main( int argc, char** args, char** envs )
{
        char sc;
        unsigned char uc;

        sc = uc = -3;

        printf( "signed char: %d unsigned char: %d\n", sc, uc );
        if ( sc > (char)0 )
                printf( "sc is greater than zero\n" );
        else
                printf( "sc is less or equal to zero\n" );

        return 0;
}

The preceeding code would produce the following unexpected result --

signed char: 253 unsigned char: 253
sc is greater than zero

Making the following change --

        signed char sc;
        unsigned char uc;
	.
	.

Would produce the expected result --

signed char: -3 unsigned char: 253
sc is less or equal to zero

Can someone shed some light on this? (As in, is this "normal" and we do
not know only because we've been living under a rock ;-)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
