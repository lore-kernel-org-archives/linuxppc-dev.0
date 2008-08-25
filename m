Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 3796EDE23E
	for <linuxppc-dev@ozlabs.org>; Mon, 25 Aug 2008 23:07:24 +1000 (EST)
From: David Jander <david.jander@protonic.nl>
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: Efficient memcpy()/memmove() for G2/G3 cores...
Date: Mon, 25 Aug 2008 15:06:33 +0200
References: <200808251131.02071.david.jander@protonic.nl>
	<48B290BA.7060202@genesi-usa.com>
In-Reply-To: <48B290BA.7060202@genesi-usa.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_a5qsITyY1ZQZ6ie"
Message-Id: <200808251506.34450.david.jander@protonic.nl>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Boundary-00=_a5qsITyY1ZQZ6ie
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Hi Matt,

On Monday 25 August 2008 13:00:10 Matt Sealey wrote:
> The focus has definitely been on VMX but that's not to say lower power
> processors were forgotten :)

lower-power (pun intended) is coming strong these days, as energy-efficiency 
is getteing more important every day. And the MPC5121 is a brand-new embedded 
processor, that will pop-up in quite a lot devices around you most 
probably ;-)

> Gunnar von Boehn did some benchmarking with an assembly optimized routine,
> for Cell, 603e and so on (basically the whole gamut from embedded up to
> sever class IBM chips) and got some pretty good results;
>
> http://www.powerdeveloper.org/forums/viewtopic.php?t=1426
>
> It is definitely something that needs fixing. The generic routine in glibc
> just copies words with no benefit of knowing the cache line size or any
> cache block buffers in the chip, and certainly no use of cache control or
> data streaming on higher end chips.
>
> With knowledge of the right way to unroll the loops, how many copies to
> do at once to try and get a burst, reducing cache usage etc. you can get
> very impressive performance (as you can see, 50MB up to 78MB at the
> smallest size, the basic improvement is 2x performance).
>
> I hope that helps you a little bit. Gunnar posted code to this list not
> long after. I have a copy of the "e300 optimized" routine but I thought
> best he should post it here, than myself.

Ok, I think I found it on the thread. The only problem is, that AFAICS it can 
be much better... at least on my platform (e300 core), and I don't know why! 
Can you explain this?

I did this:

I took Gunnars code (copy-paste from the forum), renamed the function from 
memcpy_e300 to memcpy and put it in a file called "memcpy_e300.S". Then I 
did:

$ gcc -O2 -Wall -shared -o libmemcpye300.so memcpy_e300.S

I tried the performance with the small program in the attachment:

$ gcc -O2 -Wall -o pruvmem pruvmem.c
$ LD_PRELOAD=..../libmemcpye300.so ./pruvmem

Data rate:  45.9 MiB/s

Now I did the same thing with my own memcpy written in C (see attached file 
mymemcpy.c):

$ LD_PRELOAD=..../libmymemcpy.so ./pruvmem

Data rate:  72.9 MiB/s

Now, can someone please explain this?

As a reference, here's glibc's performance:

$ ./pruvmem

Data rate:  14.8 MiB/s

> There is a lot of scope I think for optimizing several points (glibc,
> kernel, some applications) for embedded processors which nobody is
> really taking on. But, not many people want to do this kind of work..

They should! It makes a HUGE difference. I surely will of course.

Greetings,

-- 
David Jander

--Boundary-00=_a5qsITyY1ZQZ6ie
Content-Type: text/x-csrc;
  charset="utf-8";
  name="pruvmem.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="pruvmem.c"

#include <stdio.h>
#include <sys/mman.h>
#include <string.h>
#include <sys/time.h>
#include <time.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

int main(void)
{
        int f;
        unsigned long int *mem,*src,*dst;
        int t;
        long int usecs;
        unsigned long int secs, count;
        double rate;
        struct timeval tv, tv0, tv1;

        printf("Opening fb0\n");
        f = open("/dev/fb0", O_RDWR);
        if(f<0) {
                perror("opening fb0");
                return 1;
        }
        printf("mmapping fb0\n");

        mem = mmap(NULL, 0x00300000, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_LOCKED,f,0);

        printf("mmap returned: %08x\n",(unsigned int)mem);
        perror("mmap");
        if(mem==-1)
                return 1;

        gettimeofday(&tv, NULL);
        for(t=0; t<0x000c0000; t++)
                mem[t] = (tv.tv_usec ^ tv.tv_sec) ^ t;
        count = 0;
        gettimeofday(&tv0, NULL);
        for(t=0; t<10; t++) {
                src = mem;
                dst = mem+0x00040000;
                memcpy(dst, src, 0x00100000);
                count += 0x00100000;
        }
        gettimeofday(&tv1, NULL);
        secs = tv1.tv_sec-tv0.tv_sec;
        usecs = tv1.tv_usec-tv0.tv_usec;
        if(usecs<0) {
                usecs += 1000000;
                secs -= 1;
        }
        printf("Time elapsed: %ld secs, %ld usecs data transferred: %ld bytes\n",secs, usecs, count);
        rate = (double)count/((double)secs + (double)usecs/1000000.0);
        printf("Data rate: %5.3g MiB/s\n", rate/(1024.0*1024.0));

        return 0;
}

--Boundary-00=_a5qsITyY1ZQZ6ie
Content-Type: text/x-csrc;
  charset="utf-8";
  name="mymemcpy.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="mymemcpy.c"

#include <stdlib.h>
void * memcpy(void * dst, void const * src, size_t len)
{
        unsigned long int a,b,c,d;
        unsigned long int a1,b1,c1,d1;
        unsigned long int a2,b2,c2,d2;
        unsigned long int a3,b3,c3,d3;
    long * plDst = (long *) dst;
    long const * plSrc = (long const *) src;
    //if (!((unsigned long)src & 0xFFFFFFFC) && !((unsigned long)dst & 0xFFFFFFFC))
    //{
        while (len >= 64)
        {
                        a =  plSrc[0];
                        b =  plSrc[1];
                        c =  plSrc[2];
                        d =  plSrc[3];
                        a1 = plSrc[4];
                        b1 = plSrc[5];
                        c1 = plSrc[6];
                        d1 = plSrc[7];
                        a2 = plSrc[8];
                        b2 = plSrc[9];
                        c2 = plSrc[10];
                        d2 = plSrc[11];
                        a3 = plSrc[12];
                        b3 = plSrc[13];
                        c3 = plSrc[14];
                        d3 = plSrc[15];
                        plSrc += 16;
                        plDst[0] = a;
                        plDst[1] = b;
                        plDst[2] = c;
                        plDst[3] = d;
                        plDst[4] = a1;
                        plDst[5] = b1;
                        plDst[6] = c1;
                        plDst[7] = d1;
                        plDst[8] = a2;
                        plDst[9] = b2;
                        plDst[10] = c2;
                        plDst[11] = d2;
                        plDst[12] = a3;
                        plDst[13] = b3;
                        plDst[14] = c3;
                        plDst[15] = d3;
                        plDst += 16;
            len -= 64;
        }
        while(len >= 16) {
            a =  plSrc[0];
            b =  plSrc[1];
            c =  plSrc[2];
            d =  plSrc[3];
            plSrc += 4;
            plDst[0] = a;
            plDst[1] = b;
            plDst[2] = c;
            plDst[3] = d;
            plDst += 4;
            len -= 16;
        }
    //}
    char * pcDst = (char *) plDst;
    char const * pcSrc = (char const *) plSrc;

    while (len--)
    {
        *pcDst++ = *pcSrc++;
    }
    return (dst);
}

--Boundary-00=_a5qsITyY1ZQZ6ie--
