Message-ID: <3BBC34D9.B60D1BC9@esd-electronics.com>
Date: Thu, 04 Oct 2001 12:07:21 +0200
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
MIME-Version: 1.0
To: Pierre AUBERT <p.aubert@staubli.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: simple access to mem mapped peripheral
References: <B25E2E5A003CD311B61E00902778AF2A02637AB3@SERVER1> <3BBC179A.394FFD71@esd-electronics.com> <3BBC1AAC.AAA004C@staubli.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Pierre,

thanks. mmap is working fine for my problem ! I wonder why lseek'ing and
reading does not work.

Matthias


Pierre AUBERT wrote:

> I think that you can try the mmap function :
>
>     int mmap_fd;
>
>     /* Open the memory device and mmap the chip registers     */
>     if ((mmap_fd = open("/dev/mem", O_RDWR)) < 0 ) {
>         perror("open(/dev/mem)");
>         exit(1);
>     }
>     ptr = (chip_register *)mmap(NULL, CHIP_MEM_SIZE,
>                           (PROT_READ|PROT_WRITE),
>                           MAP_SHARED, mmap_fd, CHIP_PHYSICAL_ADDRESS);
>     if ( ((int)ptr) < 0 ) {
>         perror("mmap()");
>         close(mmap_fd);
>         exit(1);
>     }
>     else {
>
>         /* Read and write your chip registers ... */
>
>         munmap (ptr, CHIP_MEM_SIZE);
>         close(mmap_fd);
>     }
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
