Return-Path: <larry.finger@gmail.com>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 77A67B6FB4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Apr 2012 01:38:25 +1000 (EST)
Received: by obbup19 with SMTP id up19so1230026obb.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Apr 2012 08:38:22 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <4F9ABD67.3060704@lwfinger.net>
Date: Fri, 27 Apr 2012 10:38:15 -0500
From: Larry Finger <Larry.Finger@lwfinger.net>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Regression in 32-bit ppc kernel
References: <4F973026.3020103@lwfinger.net>
 <1335311621.15830.42.camel@pasglop> <4F976352.4060001@lwfinger.net>
 <1335327081.21961.28.camel@pasglop> <4F98117C.7080309@lwfinger.net>
 <1335390257.21961.53.camel@pasglop>
In-Reply-To: <1335390257.21961.53.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/25/2012 04:44 PM, Benjamin Herrenschmidt wrote:
>
> Do we know what the bad interrupt maps to ? Also what is the value of
> NR_IRQ and do you have SPARSE_IRQ enabled ? Can you try with the latter
> disabled and NR_IRQ set to something large, such as 128 ?
>
> (You may be able to check the interrupt mapping in debugfs)

Sorry, I was unable to find anything in debugfs to help me learn about interrupt 
mapping. The value of CONFIG_NR_IRQS is already 512. I have not tried reducing 
it to 128. The setting for CONFIG_SPARSE_IRQ was on, and changing it to off did 
not make any difference.

I finished the bisection, which led to

commit a79dd5ae5a8f49688d65b89a859f2b98a7ee5538
Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Thu Dec 15 11:13:03 2011 +1100

     tty/serial/pmac_zilog: Fix suspend & resume

As this seemed to be an improbable result, I did the full test by checking out 
the previous commit (43ca5d3). That resulted in a "good" result. Then I used 
quilt to add commit a79dd5a as a patch and the fault returned. I then noticed 
that you said in the commit message that "I removed some code for handling 
unexpected interrupt which should never be hit...". It appears that my box does 
indeed hit such an unexpected interrupt.

I could always get rid of the fault by disabling CONFIG_SERIAL_PMACZILOG, but I 
would like to fix the problem if possible.

Thanks,

Larry
