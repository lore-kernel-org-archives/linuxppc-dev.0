Subject: Re: UART driver problem
To: pavel_roskin@geocities.com (Pavel Roskin)
Date: Wed, 5 Apr 2000 15:34:43 +1000 (EST)
Cc: erammsu@kieraypc01.p.y.ki.era.ericsson.se (Marcus Sundberg),
        linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.21.0002150923400.11610-100000@sunapee.transcept.com> from "Pavel Roskin" at Feb 15, 2000 09:41:33 AM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000405053443.B19F2505F0@brixi.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi guys,

Pavel Roskin writes:
> drivers/char/serial.c is not broken!

[ explaination of why the code looks correct deleted ]

Sorry to dredge up the past here, but I'm still confused about one thing:
why does write(2) to a tty return successfully when passed an invalid address?

Here's an example:

    #include <unistd.h>

    int main()
    {
	printf("bad write returned %d\n", write(1, 0, 1));
	perror("write");
	return 0;
    }

When run on Linux/PPC or Linux/i386, you get:
    bad write returned 1
    write: Success

I would have expected the SunOS result of:
    bad write returned -1
    write: Bad address

There was a discussion about this on the linux-kernel mailing list, under
the subject "bug in write(2) system call", but I can't see where to fix it.

Any clues?

Thanks,
Graham

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
