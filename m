Return-Path: <larry.finger@gmail.com>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
 [209.85.210.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9105CB6FE6
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Apr 2012 09:17:41 +1000 (EST)
Received: by iakh37 with SMTP id h37so3016429iak.38
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Apr 2012 16:17:39 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <4F9C7A8E.1020009@lwfinger.net>
Date: Sat, 28 Apr 2012 18:17:34 -0500
From: Larry Finger <Larry.Finger@lwfinger.net>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Regression in 32-bit ppc kernel
References: <4F973026.3020103@lwfinger.net>
 <1335311621.15830.42.camel@pasglop> <4F976352.4060001@lwfinger.net>
 <1335327081.21961.28.camel@pasglop> <4F98117C.7080309@lwfinger.net>
 <1335390257.21961.53.camel@pasglop> <4F9ABD67.3060704@lwfinger.net>
 <1335565573.20866.7.camel@pasglop> <4F9B3398.9060701@lwfinger.net>
 <1335573757.20866.12.camel@pasglop> <4F9C3252.7020508@lwfinger.net>
 <m2y5pflnqk.fsf@igel.home> <1335653288.20866.15.camel@pasglop>
In-Reply-To: <1335653288.20866.15.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Paul Mackerras <paulus@samba.org>, Andreas Schwab <schwab@linux-m68k.org>,
 linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/28/2012 05:48 PM, Benjamin Herrenschmidt wrote:
> On Sat, 2012-04-28 at 20:23 +0200, Andreas Schwab wrote:
>> Larry Finger<Larry.Finger@lwfinger.net>  writes:
>>
>>> I have done a little more debugging. The problem is definitely coming from
>>> drivers/tty/serial/pmac_zilog.c. I am getting ChanB interrupts while open,
>>> which causes the following code segment to return IRQ_NONE:
>>>
>>>         if (r3&  (CHBEXT | CHBTxIP | CHBRxIP)) {
>>>                 if (!ZS_IS_OPEN(uap_a)) {
>>
>> s/uap_a/uap_b/?
>
> Good catch... Let's see if that fixes it for Larry...

Yes, good catch by Andreas. That change does fix the problem.

Ben - Do you want to fix the typos for open/not open with the same patch?

Larry
