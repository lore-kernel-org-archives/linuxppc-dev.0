MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: ppc405ep GPIO register mmap'ing invalid argument
Date: Tue, 27 Apr 2004 16:23:04 -0700
Message-ID: <C7FFFEA58B43D311920D0004ACE5333F132B016F@amer25.avnet.com>
From: "Kerl, John" <John.Kerl@Avnet.com>
To: "Kerl, John" <John.Kerl@Avnet.com>,
	"Charles Frey" <charlesf@wciatl.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Oop, I meant:

So you want to map a page (probably 4K) at 0xef600000,
then read/write the returned offset, + 0x700.

-----Original Message-----
From: Kerl, John
Sent: Tuesday, April 27, 2004 4:22 PM
To: Kerl, John; 'Charles Frey'; 'linuxppc-embedded@lists.linuxppc.org'
Subject: RE: ppc405ep GPIO register mmap'ing invalid argument


Also the offset must be a multiple of getpagesize().
So you want to map a page (probably 4K) at 0xef600700,
then read/write the returned offset, + 0x700.

-----Original Message-----
From: Kerl, John
Sent: Tuesday, April 27, 2004 4:20 PM
To: 'Charles Frey'; linuxppc-embedded@lists.linuxppc.org
Subject: RE: ppc405ep GPIO register mmap'ing invalid argument


Check the manpage:  length must be a multiple of getpagesize().
Which your 4 evidently is not.

-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org]
Sent: Tuesday, April 27, 2004 3:57 PM
To: linuxppc-embedded@lists.linuxppc.org
Subject: ppc405ep GPIO register mmap'ing invalid argument



Hey,
 I'm trying to read and write from the GPIO_OR register on an ibm 405ep
(0xEF600700), and just as I've seen on this list and other places on the
net, I do this:

   if ((m_fp = open("/dev/mem", O_RDWR)) < 0)
   {
      printf("Can't open /dev/mem\n");
      return(-1);
   }

   offset = 0xef600700 / getpagesize();
   data = mmap(0, 4, PROT_READ | PROT_WRITE, MAP_SHARED, m_fp, offset);

And it always fails with "Invalid Argument".  The mmap man page seems to
suggest you have to pass the address as a multiple of the pagesize, so that
why I do that.  But I've also tried passing 0xEF600700 straight in, and
I've tried setting length to a getpagesize() as well (as opposed to 4) to
see if I was asking for too little, but still is fails the same way.  At
first I thought this just wasn't a valid operation, but I've seen so many
examples now that I don't believe that's it.  Can anybody point me in the
right direction?

As a somewhat related question, I can "cat /dev/mem > test.bin" and it
comes out to be something like 67 megs, and this board has 64 megs of RAM.
I'm confused as to why the entire 4 GB memory space doesn't come out?

Thanks!
-Charles


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
