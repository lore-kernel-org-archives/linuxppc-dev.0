Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rM1Sk0hWkzDq7w
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Jun 2016 10:05:42 +1000 (AEST)
Message-ID: <1464998738.22191.42.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>, Linux PPC Mailing List
 <linuxppc-dev@lists.ozlabs.org>
Date: Fri, 03 Jun 2016 19:05:38 -0500
In-Reply-To: <alpine.LFD.2.20.1605101703320.6285@localhost.localdomain>
References: <alpine.LFD.2.20.1605101703320.6285@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: on a MPC8360 system, how can i read the *actual* bus frequencies?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-05-10 at 17:11 -0400, Robert P. J. Day wrote:
>   bit of a conundrum here ... we have a legacy MPC8360 system here, on
> which we installed linux built with wind river linux 8. we obviously
> want to push the various bus frequencies to their max for best
> performance, and the device tree that was being used for this system
> assigned rather slow speeds (266MHz) for the various buses.
> 
>   i wasn't sure how to view the bus frequencies that were *actually*
> being used. first, i thought that anything you found under
> /proc/devicetree simply showed the device tree values as they were
> passed to the kernel, so i wasn't going to trust those.
> 
>   also, i thought that anything under /sys would show the genuine
> frequency values and, after searching, i found various PPC bus
> frequencies under /sys/firmware/..., but they *also* showed fairly
> slow speeds.
> 
>   finally, someone wrote a program that read directly from the
> system registers:
> 
>     tempVal = *M83XX_SPMR(vxCCSBARGet());
>     lbcm   = M83XX_SPMR_LBCM_VAL(tempVal);
>     ddrcm = M83XX_SPMR_DDRCM_VAL(tempVal);
>     spmf   = M83XX_SPMR_SPMF_VAL(tempVal);
>     clkDiv      = M83XX_SPMR_CLKID_VAL(tempVal);
>     corePll = M83XX_SPMR_COREPLL_VAL(tempVal);
>     cepdf  = M83XX_SPMR_CEPDF_VAL(tempVal);
>     cepmf  = M83XX_SPMR_CEPMF_VAL(tempVal);
> 
> which, surprisingly, showed what appears to be the maximum allowable
> bus frequencies; for example
> 
>   Enter mcd command -> sysGetCoreSpeed
>   value = 533332800 = 0x1fca0340
> 
> so i'm willing to believe that the system really is running at max
> speed, but is there no easier way to see the bus frequencies that are
> actually in use, rather than having to dig into the system registers?
> 
>   why would the values under /sys not reflect the actual bus
> frequencies, and not (as it appears) just the ones passed to the
> kernel which were obviously not used?

I'm not familiar with /sys/firmware but I don't think there's anything in the
kernel that cares about CPU speed on these chips (no cpufreq or clock driver),
so why would it do anything other than trust the device tree?  If the device
tree is wrong, fix that.

If you want the core frequency, look in the CPU node, not the speed of
"various buses".

-Scott
