Date: Fri, 31 Mar 2000 09:27:07 -0500
From: Josh Huber <huberj@wpi.edu>
To: Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Subject: gcc bug
Message-ID: <20000331092707.C354@wpi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Interesting gcc bug here...

in both cases this should print 0xDEADBEEF, but in the second case, garbage
is printed.

main()
{
	unsigned long t1 = 32;
	unsigned long long t2 = 64;

	printf("%x\n", 1 ? 0xDEADBEEF : t1);
	printf("%x\n", 1 ? 0xDEADBEEF : t2);
}

as expected, the 1 ? ... operation is optimized away, but the compiler seems
to screw things up ...

working case:
	li 4,15
	crxor 6,6,6
	bl printf

failure case:
	li 5,0
	li 6,15
	crxor 6,6,6
	bl printf

in the failure case, r4 is not loaded with anything, so this is were the
garbage probably comes from.

This is a greatly simplified version of an actual piece of code (obviously,
as the code above is silly :)

Josh

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
