Return-Path: <domino@mikroswiat.pl>
Received: from jupiter.az.pl (jupiter.az.pl [62.146.68.61])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CB285DDE01
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Oct 2008 01:52:27 +1100 (EST)
Received: from afp172.internetdsl.tpnet.pl ([83.16.145.172] helo=[192.168.2.8])
	by jupiter.az.pl with esmtpsa (TLSv1:AES256-SHA:256) (Exim 4.68)
	(envelope-from <domino@mikroswiat.pl>) id 1KnaCc-0001uf-Up
	for linuxppc-embedded@ozlabs.org; Wed, 08 Oct 2008 16:39:51 +0200
Message-ID: <48ECC611.3030309@mikroswiat.pl>
Date: Wed, 08 Oct 2008 16:39:13 +0200
From: Dominik Bozek <domino@mikroswiat.pl>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: performance: memcpy vs. __copy_tofrom_user
Content-Type: text/plain; charset=ISO-8859-2
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I have done a test of memcpy() and __copy_tofrom_user() on the mpc8313.
And the major conclusion is that __copy_tofrom_user is more efficient
than memcpy. Sometimes about 40%.

If I good understand, the memcpy() just copy the data, while
__copy_tofrom_user() take care if the memory wasn't swapped out. So then
memcpy() shall be faster than __copy_tofrom_user(). Am I right?
Is here anybody, who can confirm such results and maybe is able to
improve the memcpy()?


Let talk about the test.
I have prepared two pieces of memory of size 64KB and I make sure that
this memory is not swapped out (necessary for memcpy() later). Then I
run one of the memory copy function to transfer 32MB and I measure the
time. The memory is copied in chunks from 64KB to 8B. I take care about
the cache calling flush_dcache_range() whenever whole 64KB was used.
I know, that memcpy on the kernel level is not intended to copy memory
blocks in userspace and __copy_tofrom_user is not intended to copy data
only between two user blocks, but for the performance test it doesn't
matter.
Bellow you may see the short piece of code in the kernel module.

#define TEST_BUF_SIZE (64*1024)
int function;
char *buf1, *buf2, *buf1_bis, *buf2_bis;
unsigned int size, cnt;

get_user(function, &((TEST_ARG*)(arg))->function);
get_user(buf1, &((TEST_ARG*)(arg))->buf1);
get_user(buf2, &((TEST_ARG*)(arg))->buf2);
get_user(size, &((TEST_ARG*)(arg))->size);

cnt = (32*1024*1024)/size; /* how many repeats of memory copy is needed
to transfer 32MB ? */
buf1_bis = buf1;
buf2_bis = buf2;

switch (function)
{
    case MEMCPY_TEST:
        while (cnt-->0)
        {
            if (buf1_bis >= buf1+TEST_BUF_SIZE)
            {
                /* need for flusch data cache as seldom as possible */
                buf1_bis = buf1;
                buf2_bis = buf2;
                flush_dcache_range((int)buf1, (int)(buf2+TEST_BUF_SIZE));
            }
            if (buf1_bis != memcpy(buf1_bis, buf2_bis, size))
                break;
            buf1_bis += size;
            buf2_bis += size;
        }
        break;

    case COPY_TOFROM_USER_TEST:
        while (cnt-->0)
        {
            if (buf1_bis >= buf1+TEST_BUF_SIZE)
            {
                /* need for flusch data cache as seldom as possible */
                buf1_bis = buf1;
                buf2_bis = buf2;
                flush_dcache_range((int)buf1, (int)(buf2+TEST_BUF_SIZE));
            }
            ret = __copy_tofrom_user(buf1_bis, buf2_bis, size);
            if (ret != 0)
                break;
            buf1_bis += size;
            buf2_bis += size;
        }
        break;
}


Bellow are the results:

memcpy()
chunk:  65536 [B] | transfer:     69.2 [MB/s] | time: 1.849727 [s] |
size:  128.000 [MB]
chunk:  32768 [B] | transfer:     69.2 [MB/s] | time: 1.849700 [s] |
size:  128.000 [MB]
chunk:  16384 [B] | transfer:     69.2 [MB/s] | time: 1.849845 [s] |
size:  128.000 [MB]
chunk:   8192 [B] | transfer:     69.2 [MB/s] | time: 1.850535 [s] |
size:  128.000 [MB]
chunk:   4096 [B] | transfer:     69.1 [MB/s] | time: 1.853405 [s] |
size:  128.000 [MB]
chunk:   2048 [B] | transfer:     69.1 [MB/s] | time: 1.852877 [s] |
size:  128.000 [MB]
chunk:   1024 [B] | transfer:     69.2 [MB/s] | time: 1.849963 [s] |
size:  128.000 [MB]
chunk:    512 [B] | transfer:     69.0 [MB/s] | time: 1.853793 [s] |
size:  128.000 [MB]
chunk:    256 [B] | transfer:     68.6 [MB/s] | time: 1.866222 [s] |
size:  128.000 [MB]
chunk:    128 [B] | transfer:     68.0 [MB/s] | time: 1.883002 [s] |
size:  128.000 [MB]
chunk:     64 [B] | transfer:     67.2 [MB/s] | time: 1.904073 [s] |
size:  128.000 [MB]
chunk:     32 [B] | transfer:     64.7 [MB/s] | time: 1.978109 [s] |
size:  128.000 [MB]
chunk:     16 [B] | transfer:     54.5 [MB/s] | time: 2.348682 [s] |
size:  128.000 [MB]
chunk:      8 [B] | transfer:     47.4 [MB/s] | time: 2.698635 [s] |
size:  128.000 [MB]


__copy_tofrom_user()
chunk:  65536 [B] | transfer:     97.3 [MB/s] | time: 1.315155 [s] |
size:  128.000 [MB]
chunk:  32768 [B] | transfer:     97.3 [MB/s] | time: 1.315762 [s] |
size:  128.000 [MB]
chunk:  16384 [B] | transfer:     97.2 [MB/s] | time: 1.316946 [s] |
size:  128.000 [MB]
chunk:   8192 [B] | transfer:     96.8 [MB/s] | time: 1.321705 [s] |
size:  128.000 [MB]
chunk:   4096 [B] | transfer:     96.6 [MB/s] | time: 1.325516 [s] |
size:  128.000 [MB]
chunk:   2048 [B] | transfer:     96.6 [MB/s] | time: 1.325570 [s] |
size:  128.000 [MB]
chunk:   1024 [B] | transfer:     96.8 [MB/s] | time: 1.322599 [s] |
size:  128.000 [MB]
chunk:    512 [B] | transfer:     97.8 [MB/s] | time: 1.308186 [s] |
size:  128.000 [MB]
chunk:    256 [B] | transfer:    100.2 [MB/s] | time: 1.277788 [s] |
size:  128.000 [MB]
chunk:    128 [B] | transfer:     91.5 [MB/s] | time: 1.398216 [s] |
size:  128.000 [MB]
chunk:     64 [B] | transfer:     87.0 [MB/s] | time: 1.471784 [s] |
size:  128.000 [MB]
chunk:     32 [B] | transfer:     75.0 [MB/s] | time: 1.706426 [s] |
size:  128.000 [MB]
chunk:     16 [B] | transfer:     47.8 [MB/s] | time: 2.678039 [s] |
size:  128.000 [MB]
chunk:      8 [B] | transfer:     41.5 [MB/s] | time: 3.084689 [s] |
size:  128.000 [MB]

Regards
Dominik Bozek


BTW. The memcpy() maybe optimized as it is on i32 when the size of block
is known at compile time.
