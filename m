Return-Path: <tosettofabio83@libero.it>
Received: from polito.it (unknown [130.192.3.45])
	by ozlabs.org (Postfix) with ESMTP id 82DC7DDE0D
	for <linuxppc-dev@ozlabs.org>; Wed,  7 May 2008 23:50:05 +1000 (EST)
Message-ID: <4821A551.3060205@libero.it>
Date: Wed, 07 May 2008 14:49:21 +0200
From: Fabio Tosetto <tosettofabio83@libero.it>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: MPC5200b MMC over SPI into PSC6
References: <481F4DFD.1000702@libero.it>
	<fa686aa40805060836o519bff20yf2506676ff1c3e6@mail.gmail.com>
In-Reply-To: <fa686aa40805060836o519bff20yf2506676ff1c3e6@mail.gmail.com>
Content-Type: multipart/alternative;
	boundary="------------060609030300060301030703"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------060609030300060301030703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I've tried to port my exesting configurations to the powerpc tree but 
some configurations files are missing.

I need to set PSC3 - PSC4 in uart mode:
before in file *arch/ppc/platforms/lite5200.c* I added

struct mpc52xx_psc_func mpc52xx_psc_functions[] = {
        {       .id     = 3,
                .func   = "uart",
        },
        {       .id     = 4,
                .func   = "uart",
        },
        {       .id     = -1,   /* End entry */
                .func   = NULL,
        }
};

I need to set PSC4 as a low level debug: *
*before in file  *arch/ppc/platforms/lite5200.h *I added

#define MPC52xx_PF_CONSOLE_PORT 4    /* PSC4 */


Finally I need to set  the virtual memory translation on a range of 128 MB:
before in file *arch/ppc/kernel/head.S *I added

/*ori    r11,r11,BL_128M<<2|0x2    set up BAT registers for 604 */

ori    r11,r11,BL_128M<<2|0x2    /* set up BAT registers for 604 */

could you please explain me how to do the same operations in powerpc tree??

thanks Fabio

Grant Likely ha scritto:
> On Mon, May 5, 2008 at 12:12 PM, Fabio Tosetto <tosettofabio83@libero.it> wrote:
>   
>> Hello, I have an embedded system with an on-board processor powerpc MPC5200B
>>  and Linux kernel 2.6.22,
>>  I must turn over to MMC SPI on the PSC6.
>>
>>  First, I
>>  have enabled PSC6:
>>
>>  in ../arch/ppc/platforms/lite5200.c added PSC6 in SPI mode
>>     
>
> You're using arch/ppc which is depreciated.  You should move to using
> arch/powerpc (set ARCH=powerpc when compiling).  Devices are then
> enabled in the device tree source file
> arch/powerpc/boot/dts/lite5200b.dts.
>
> Many things have changed with MPC5200 support in the last year, you
> should also use the latest kernel release (2.6.25.2 when it is
> released.  If you use 2.6.25.1, then there is a trivial bug in the psc
> serial port driver that you'll need to fix.  I'll include the link to
> the patch below)
>
> Cheers,
> g.
>
> http://ozlabs.org/pipermail/linuxppc-dev/2008-April/055495.html
>
>   


--------------060609030300060301030703
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
I've tried to port my exesting configurations to the powerpc tree but
some configurations files are missing.
<br>
<br>
I need to set PSC3 - PSC4 in uart mode:
<br>
before in file <b class="moz-txt-star"><span class="moz-txt-tag">*</span>arch/ppc/platforms/lite5200.c<span
 class="moz-txt-tag">*</span></b> I added
<br>
<br>
struct mpc52xx_psc_func mpc52xx_psc_functions[] = {
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .id&nbsp;&nbsp;&nbsp;&nbsp; = 3,
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .func&nbsp;&nbsp; = "uart",
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .id&nbsp;&nbsp;&nbsp;&nbsp; = 4,
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .func&nbsp;&nbsp; = "uart",
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .id&nbsp;&nbsp;&nbsp;&nbsp; = -1,&nbsp;&nbsp; /* End entry */
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .func&nbsp;&nbsp; = NULL,
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }
<br>
};
<br>
<br>
I need to set PSC4 as a low level debug: *
<br>
*before in file&nbsp; *arch/ppc/platforms/lite5200.h *I added
<br>
<br>
#define MPC52xx_PF_CONSOLE_PORT 4&nbsp;&nbsp;&nbsp; /* PSC4 */
<br>
<br>
<br>
Finally I need to set&nbsp; the virtual memory translation on a range of 128
MB:
<br>
before in file *arch/ppc/kernel/head.S *I added
<br>
<br>
/*ori&nbsp;&nbsp;&nbsp; r11,r11,BL_128M&lt;&lt;2|0x2&nbsp;&nbsp;&nbsp; set up BAT registers for 604
*/
<br>
<br>
ori&nbsp;&nbsp;&nbsp; r11,r11,BL_128M&lt;&lt;2|0x2&nbsp;&nbsp;&nbsp; /* set up BAT registers for 604
*/
<br>
<br>
could you please explain me how to do the same operations in powerpc
tree??
<br>
<br>
thanks Fabio
<br>
<br>
Grant Likely ha scritto:
<blockquote
 cite="mid:fa686aa40805060836o519bff20yf2506676ff1c3e6@mail.gmail.com"
 type="cite">
  <pre wrap="">On Mon, May 5, 2008 at 12:12 PM, Fabio Tosetto <a class="moz-txt-link-rfc2396E" href="mailto:tosettofabio83@libero.it">&lt;tosettofabio83@libero.it&gt;</a> wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Hello, I have an embedded system with an on-board processor powerpc MPC5200B
 and Linux kernel 2.6.22,
 I must turn over to MMC SPI on the PSC6.

 First, I
 have enabled PSC6:

 in ../arch/ppc/platforms/lite5200.c added PSC6 in SPI mode
    </pre>
  </blockquote>
  <pre wrap=""><!---->
You're using arch/ppc which is depreciated.  You should move to using
arch/powerpc (set ARCH=powerpc when compiling).  Devices are then
enabled in the device tree source file
arch/powerpc/boot/dts/lite5200b.dts.

Many things have changed with MPC5200 support in the last year, you
should also use the latest kernel release (2.6.25.2 when it is
released.  If you use 2.6.25.1, then there is a trivial bug in the psc
serial port driver that you'll need to fix.  I'll include the link to
the patch below)

Cheers,
g.

<a class="moz-txt-link-freetext" href="http://ozlabs.org/pipermail/linuxppc-dev/2008-April/055495.html">http://ozlabs.org/pipermail/linuxppc-dev/2008-April/055495.html</a>

  </pre>
</blockquote>
<br>
</body>
</html>

--------------060609030300060301030703--
