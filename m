Date: Tue, 27 Apr 2004 18:57:02 -0400
From: Charles Frey <charlesf@wciatl.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: ppc405ep GPIO register mmap'ing invalid argument
Message-ID: <10074256.1083092222@[192.168.0.66]>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


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
