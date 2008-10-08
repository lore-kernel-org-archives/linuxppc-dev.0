Return-Path: <minhtuanmt1@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.239])
	by ozlabs.org (Postfix) with ESMTP id A260ADE3C5
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Oct 2008 02:31:57 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id s6so885180wxc.15
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 08 Oct 2008 08:31:55 -0700 (PDT)
Message-ID: <9a53cf970810080831t3e79bef7i1ad05deb993494b7@mail.gmail.com>
Date: Wed, 8 Oct 2008 22:31:54 +0700
From: "Minh Tuan Duong" <minhtuanmt1@gmail.com>
To: "Dominik Bozek" <domino@mikroswiat.pl>
Subject: Re: performance: memcpy vs. __copy_tofrom_user
In-Reply-To: <48ECC611.3030309@mikroswiat.pl>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_75077_31306074.1223479915129"
References: <48ECC611.3030309@mikroswiat.pl>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_75077_31306074.1223479915129
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

http://www.xml.com/ldd/chapter/book/ch03.html
Hope this help.

On Wed, Oct 8, 2008 at 9:39 PM, Dominik Bozek <domino@mikroswiat.pl> wrote:

> Hi all,
>
> I have done a test of memcpy() and __copy_tofrom_user() on the mpc8313.
> And the major conclusion is that __copy_tofrom_user is more efficient
> than memcpy. Sometimes about 40%.
>
> If I good understand, the memcpy() just copy the data, while
> __copy_tofrom_user() take care if the memory wasn't swapped out. So then
> memcpy() shall be faster than __copy_tofrom_user(). Am I right?
> Is here anybody, who can confirm such results and maybe is able to
> improve the memcpy()?
>
>
> Let talk about the test.
> I have prepared two pieces of memory of size 64KB and I make sure that
> this memory is not swapped out (necessary for memcpy() later). Then I
> run one of the memory copy function to transfer 32MB and I measure the
> time. The memory is copied in chunks from 64KB to 8B. I take care about
> the cache calling flush_dcache_range() whenever whole 64KB was used.
> I know, that memcpy on the kernel level is not intended to copy memory
> blocks in userspace and __copy_tofrom_user is not intended to copy data
> only between two user blocks, but for the performance test it doesn't
> matter.
> Bellow you may see the short piece of code in the kernel module.
>
> #define TEST_BUF_SIZE (64*1024)
> int function;
> char *buf1, *buf2, *buf1_bis, *buf2_bis;
> unsigned int size, cnt;
>
> get_user(function, &((TEST_ARG*)(arg))->function);
> get_user(buf1, &((TEST_ARG*)(arg))->buf1);
> get_user(buf2, &((TEST_ARG*)(arg))->buf2);
> get_user(size, &((TEST_ARG*)(arg))->size);
>
> cnt = (32*1024*1024)/size; /* how many repeats of memory copy is needed
> to transfer 32MB ? */
> buf1_bis = buf1;
> buf2_bis = buf2;
>
> switch (function)
> {
>    case MEMCPY_TEST:
>        while (cnt-->0)
>        {
>            if (buf1_bis >= buf1+TEST_BUF_SIZE)
>            {
>                /* need for flusch data cache as seldom as possible */
>                buf1_bis = buf1;
>                buf2_bis = buf2;
>                flush_dcache_range((int)buf1, (int)(buf2+TEST_BUF_SIZE));
>            }
>            if (buf1_bis != memcpy(buf1_bis, buf2_bis, size))
>                break;
>            buf1_bis += size;
>            buf2_bis += size;
>        }
>        break;
>
>    case COPY_TOFROM_USER_TEST:
>        while (cnt-->0)
>        {
>            if (buf1_bis >= buf1+TEST_BUF_SIZE)
>            {
>                /* need for flusch data cache as seldom as possible */
>                buf1_bis = buf1;
>                buf2_bis = buf2;
>                flush_dcache_range((int)buf1, (int)(buf2+TEST_BUF_SIZE));
>            }
>            ret = __copy_tofrom_user(buf1_bis, buf2_bis, size);
>            if (ret != 0)
>                break;
>            buf1_bis += size;
>            buf2_bis += size;
>        }
>        break;
> }
>
>
> Bellow are the results:
>
> memcpy()
> chunk:  65536 [B] | transfer:     69.2 [MB/s] | time: 1.849727 [s] |
> size:  128.000 [MB]
> chunk:  32768 [B] | transfer:     69.2 [MB/s] | time: 1.849700 [s] |
> size:  128.000 [MB]
> chunk:  16384 [B] | transfer:     69.2 [MB/s] | time: 1.849845 [s] |
> size:  128.000 [MB]
> chunk:   8192 [B] | transfer:     69.2 [MB/s] | time: 1.850535 [s] |
> size:  128.000 [MB]
> chunk:   4096 [B] | transfer:     69.1 [MB/s] | time: 1.853405 [s] |
> size:  128.000 [MB]
> chunk:   2048 [B] | transfer:     69.1 [MB/s] | time: 1.852877 [s] |
> size:  128.000 [MB]
> chunk:   1024 [B] | transfer:     69.2 [MB/s] | time: 1.849963 [s] |
> size:  128.000 [MB]
> chunk:    512 [B] | transfer:     69.0 [MB/s] | time: 1.853793 [s] |
> size:  128.000 [MB]
> chunk:    256 [B] | transfer:     68.6 [MB/s] | time: 1.866222 [s] |
> size:  128.000 [MB]
> chunk:    128 [B] | transfer:     68.0 [MB/s] | time: 1.883002 [s] |
> size:  128.000 [MB]
> chunk:     64 [B] | transfer:     67.2 [MB/s] | time: 1.904073 [s] |
> size:  128.000 [MB]
> chunk:     32 [B] | transfer:     64.7 [MB/s] | time: 1.978109 [s] |
> size:  128.000 [MB]
> chunk:     16 [B] | transfer:     54.5 [MB/s] | time: 2.348682 [s] |
> size:  128.000 [MB]
> chunk:      8 [B] | transfer:     47.4 [MB/s] | time: 2.698635 [s] |
> size:  128.000 [MB]
>
>
> __copy_tofrom_user()
> chunk:  65536 [B] | transfer:     97.3 [MB/s] | time: 1.315155 [s] |
> size:  128.000 [MB]
> chunk:  32768 [B] | transfer:     97.3 [MB/s] | time: 1.315762 [s] |
> size:  128.000 [MB]
> chunk:  16384 [B] | transfer:     97.2 [MB/s] | time: 1.316946 [s] |
> size:  128.000 [MB]
> chunk:   8192 [B] | transfer:     96.8 [MB/s] | time: 1.321705 [s] |
> size:  128.000 [MB]
> chunk:   4096 [B] | transfer:     96.6 [MB/s] | time: 1.325516 [s] |
> size:  128.000 [MB]
> chunk:   2048 [B] | transfer:     96.6 [MB/s] | time: 1.325570 [s] |
> size:  128.000 [MB]
> chunk:   1024 [B] | transfer:     96.8 [MB/s] | time: 1.322599 [s] |
> size:  128.000 [MB]
> chunk:    512 [B] | transfer:     97.8 [MB/s] | time: 1.308186 [s] |
> size:  128.000 [MB]
> chunk:    256 [B] | transfer:    100.2 [MB/s] | time: 1.277788 [s] |
> size:  128.000 [MB]
> chunk:    128 [B] | transfer:     91.5 [MB/s] | time: 1.398216 [s] |
> size:  128.000 [MB]
> chunk:     64 [B] | transfer:     87.0 [MB/s] | time: 1.471784 [s] |
> size:  128.000 [MB]
> chunk:     32 [B] | transfer:     75.0 [MB/s] | time: 1.706426 [s] |
> size:  128.000 [MB]
> chunk:     16 [B] | transfer:     47.8 [MB/s] | time: 2.678039 [s] |
> size:  128.000 [MB]
> chunk:      8 [B] | transfer:     41.5 [MB/s] | time: 3.084689 [s] |
> size:  128.000 [MB]
>
> Regards
> Dominik Bozek
>
>
> BTW. The memcpy() maybe optimized as it is on i32 when the size of block
> is known at compile time.
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>



-- 
Best regards,
Tuan Duong
Mobile: 0983349121

------=_Part_75077_31306074.1223479915129
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr"><a href="http://www.xml.com/ldd/chapter/book/ch03.html">http://www.xml.com/ldd/chapter/book/ch03.html</a><br>Hope this help.<br><br><div class="gmail_quote">On Wed, Oct 8, 2008 at 9:39 PM, Dominik Bozek <span dir="ltr">&lt;domino@mikroswiat.pl&gt;</span> wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi all,<br>
<br>
I have done a test of memcpy() and __copy_tofrom_user() on the mpc8313.<br>
And the major conclusion is that __copy_tofrom_user is more efficient<br>
than memcpy. Sometimes about 40%.<br>
<br>
If I good understand, the memcpy() just copy the data, while<br>
__copy_tofrom_user() take care if the memory wasn&#39;t swapped out. So then<br>
memcpy() shall be faster than __copy_tofrom_user(). Am I right?<br>
Is here anybody, who can confirm such results and maybe is able to<br>
improve the memcpy()?<br>
<br>
<br>
Let talk about the test.<br>
I have prepared two pieces of memory of size 64KB and I make sure that<br>
this memory is not swapped out (necessary for memcpy() later). Then I<br>
run one of the memory copy function to transfer 32MB and I measure the<br>
time. The memory is copied in chunks from 64KB to 8B. I take care about<br>
the cache calling flush_dcache_range() whenever whole 64KB was used.<br>
I know, that memcpy on the kernel level is not intended to copy memory<br>
blocks in userspace and __copy_tofrom_user is not intended to copy data<br>
only between two user blocks, but for the performance test it doesn&#39;t<br>
matter.<br>
Bellow you may see the short piece of code in the kernel module.<br>
<br>
#define TEST_BUF_SIZE (64*1024)<br>
int function;<br>
char *buf1, *buf2, *buf1_bis, *buf2_bis;<br>
unsigned int size, cnt;<br>
<br>
get_user(function, &amp;((TEST_ARG*)(arg))-&gt;function);<br>
get_user(buf1, &amp;((TEST_ARG*)(arg))-&gt;buf1);<br>
get_user(buf2, &amp;((TEST_ARG*)(arg))-&gt;buf2);<br>
get_user(size, &amp;((TEST_ARG*)(arg))-&gt;size);<br>
<br>
cnt = (32*1024*1024)/size; /* how many repeats of memory copy is needed<br>
to transfer 32MB ? */<br>
buf1_bis = buf1;<br>
buf2_bis = buf2;<br>
<br>
switch (function)<br>
{<br>
 &nbsp; &nbsp;case MEMCPY_TEST:<br>
 &nbsp; &nbsp; &nbsp; &nbsp;while (cnt--&gt;0)<br>
 &nbsp; &nbsp; &nbsp; &nbsp;{<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (buf1_bis &gt;= buf1+TEST_BUF_SIZE)<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;{<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* need for flusch data cache as seldom as possible */<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;buf1_bis = buf1;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;buf2_bis = buf2;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;flush_dcache_range((int)buf1, (int)(buf2+TEST_BUF_SIZE));<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (buf1_bis != memcpy(buf1_bis, buf2_bis, size))<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;break;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;buf1_bis += size;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;buf2_bis += size;<br>
 &nbsp; &nbsp; &nbsp; &nbsp;}<br>
 &nbsp; &nbsp; &nbsp; &nbsp;break;<br>
<br>
 &nbsp; &nbsp;case COPY_TOFROM_USER_TEST:<br>
 &nbsp; &nbsp; &nbsp; &nbsp;while (cnt--&gt;0)<br>
 &nbsp; &nbsp; &nbsp; &nbsp;{<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (buf1_bis &gt;= buf1+TEST_BUF_SIZE)<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;{<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/* need for flusch data cache as seldom as possible */<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;buf1_bis = buf1;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;buf2_bis = buf2;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;flush_dcache_range((int)buf1, (int)(buf2+TEST_BUF_SIZE));<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ret = __copy_tofrom_user(buf1_bis, buf2_bis, size);<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (ret != 0)<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;break;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;buf1_bis += size;<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;buf2_bis += size;<br>
 &nbsp; &nbsp; &nbsp; &nbsp;}<br>
 &nbsp; &nbsp; &nbsp; &nbsp;break;<br>
}<br>
<br>
<br>
Bellow are the results:<br>
<br>
memcpy()<br>
chunk: &nbsp;65536 [B] | transfer: &nbsp; &nbsp; 69.2 [MB/s] | time: 1.849727 [s] |<br>
size: &nbsp;128.000 [MB]<br>
chunk: &nbsp;32768 [B] | transfer: &nbsp; &nbsp; 69.2 [MB/s] | time: 1.849700 [s] |<br>
size: &nbsp;128.000 [MB]<br>
chunk: &nbsp;16384 [B] | transfer: &nbsp; &nbsp; 69.2 [MB/s] | time: 1.849845 [s] |<br>
size: &nbsp;128.000 [MB]<br>
chunk: &nbsp; 8192 [B] | transfer: &nbsp; &nbsp; 69.2 [MB/s] | time: 1.850535 [s] |<br>
size: &nbsp;128.000 [MB]<br>
chunk: &nbsp; 4096 [B] | transfer: &nbsp; &nbsp; 69.1 [MB/s] | time: 1.853405 [s] |<br>
size: &nbsp;128.000 [MB]<br>
chunk: &nbsp; 2048 [B] | transfer: &nbsp; &nbsp; 69.1 [MB/s] | time: 1.852877 [s] |<br>
size: &nbsp;128.000 [MB]<br>
chunk: &nbsp; 1024 [B] | transfer: &nbsp; &nbsp; 69.2 [MB/s] | time: 1.849963 [s] |<br>
size: &nbsp;128.000 [MB]<br>
chunk: &nbsp; &nbsp;512 [B] | transfer: &nbsp; &nbsp; 69.0 [MB/s] | time: 1.853793 [s] |<br>
size: &nbsp;128.000 [MB]<br>
chunk: &nbsp; &nbsp;256 [B] | transfer: &nbsp; &nbsp; 68.6 [MB/s] | time: 1.866222 [s] |<br>
size: &nbsp;128.000 [MB]<br>
chunk: &nbsp; &nbsp;128 [B] | transfer: &nbsp; &nbsp; 68.0 [MB/s] | time: 1.883002 [s] |<br>
size: &nbsp;128.000 [MB]<br>
chunk: &nbsp; &nbsp; 64 [B] | transfer: &nbsp; &nbsp; 67.2 [MB/s] | time: 1.904073 [s] |<br>
size: &nbsp;128.000 [MB]<br>
chunk: &nbsp; &nbsp; 32 [B] | transfer: &nbsp; &nbsp; 64.7 [MB/s] | time: 1.978109 [s] |<br>
size: &nbsp;128.000 [MB]<br>
chunk: &nbsp; &nbsp; 16 [B] | transfer: &nbsp; &nbsp; 54.5 [MB/s] | time: 2.348682 [s] |<br>
size: &nbsp;128.000 [MB]<br>
chunk: &nbsp; &nbsp; &nbsp;8 [B] | transfer: &nbsp; &nbsp; 47.4 [MB/s] | time: 2.698635 [s] |<br>
size: &nbsp;128.000 [MB]<br>
<br>
<br>
__copy_tofrom_user()<br>
chunk: &nbsp;65536 [B] | transfer: &nbsp; &nbsp; 97.3 [MB/s] | time: 1.315155 [s] |<br>
size: &nbsp;128.000 [MB]<br>
chunk: &nbsp;32768 [B] | transfer: &nbsp; &nbsp; 97.3 [MB/s] | time: 1.315762 [s] |<br>
size: &nbsp;128.000 [MB]<br>
chunk: &nbsp;16384 [B] | transfer: &nbsp; &nbsp; 97.2 [MB/s] | time: 1.316946 [s] |<br>
size: &nbsp;128.000 [MB]<br>
chunk: &nbsp; 8192 [B] | transfer: &nbsp; &nbsp; 96.8 [MB/s] | time: 1.321705 [s] |<br>
size: &nbsp;128.000 [MB]<br>
chunk: &nbsp; 4096 [B] | transfer: &nbsp; &nbsp; 96.6 [MB/s] | time: 1.325516 [s] |<br>
size: &nbsp;128.000 [MB]<br>
chunk: &nbsp; 2048 [B] | transfer: &nbsp; &nbsp; 96.6 [MB/s] | time: 1.325570 [s] |<br>
size: &nbsp;128.000 [MB]<br>
chunk: &nbsp; 1024 [B] | transfer: &nbsp; &nbsp; 96.8 [MB/s] | time: 1.322599 [s] |<br>
size: &nbsp;128.000 [MB]<br>
chunk: &nbsp; &nbsp;512 [B] | transfer: &nbsp; &nbsp; 97.8 [MB/s] | time: 1.308186 [s] |<br>
size: &nbsp;128.000 [MB]<br>
chunk: &nbsp; &nbsp;256 [B] | transfer: &nbsp; &nbsp;100.2 [MB/s] | time: 1.277788 [s] |<br>
size: &nbsp;128.000 [MB]<br>
chunk: &nbsp; &nbsp;128 [B] | transfer: &nbsp; &nbsp; 91.5 [MB/s] | time: 1.398216 [s] |<br>
size: &nbsp;128.000 [MB]<br>
chunk: &nbsp; &nbsp; 64 [B] | transfer: &nbsp; &nbsp; 87.0 [MB/s] | time: 1.471784 [s] |<br>
size: &nbsp;128.000 [MB]<br>
chunk: &nbsp; &nbsp; 32 [B] | transfer: &nbsp; &nbsp; 75.0 [MB/s] | time: 1.706426 [s] |<br>
size: &nbsp;128.000 [MB]<br>
chunk: &nbsp; &nbsp; 16 [B] | transfer: &nbsp; &nbsp; 47.8 [MB/s] | time: 2.678039 [s] |<br>
size: &nbsp;128.000 [MB]<br>
chunk: &nbsp; &nbsp; &nbsp;8 [B] | transfer: &nbsp; &nbsp; 41.5 [MB/s] | time: 3.084689 [s] |<br>
size: &nbsp;128.000 [MB]<br>
<br>
Regards<br>
Dominik Bozek<br>
<br>
<br>
BTW. The memcpy() maybe optimized as it is on i32 when the size of block<br>
is known at compile time.<br>
<br>
_______________________________________________<br>
Linuxppc-embedded mailing list<br>
<a href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a><br>
<a href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded" target="_blank">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a><br>
</blockquote></div><br><br clear="all"><br>-- <br>Best regards,<br>Tuan Duong<br>Mobile: 0983349121<br>
</div>

------=_Part_75077_31306074.1223479915129--
