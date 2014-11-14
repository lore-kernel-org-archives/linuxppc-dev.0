Return-Path: <prvs=03951267c7=valentin.longchamp@keymile.com>
Received: from mail-de.keymile.com (mail-de.keymile.com [195.8.104.250])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 66C161A0292
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Nov 2014 18:43:10 +1100 (AEDT)
Message-ID: <5465B285.7070005@keymile.com>
Date: Fri, 14 Nov 2014 08:43:01 +0100
From: Valentin Longchamp <valentin.longchamp@keymile.com>
MIME-Version: 1.0
To: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c-qoriq: modified compatibility for correct prescaler
References: <1413538026-15739-1-git-send-email-valentin.longchamp@keymile.com>
 <1414537731.23458.120.camel@snotra.buserror.net> <5450AC85.40302@keymile.com>
 <20141113003418.GE2062@katana>
In-Reply-To: <20141113003418.GE2062@katana>
Content-Type: text/plain; charset=windows-1252
Cc: Linux device trees <devicetree@vger.kernel.org>, "Boschung,
 Rainer" <Rainer.Boschung@keymile.com>, "Brunck,
 Holger" <Holger.Brunck@keymile.com>, Linux I2C <linux-i2c@vger.kernel.org>,
 Scott Wood <scottwood@freescale.com>,
 Linux PowerPC Kernel <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/13/2014 01:34 AM, Wolfram Sang wrote:
> 
>> If we wanted to be on the safe side and strict (since we are not sure that the
>> hardware is 100% compatible), we maybe should add a fsl,qoriq-i2c compatible to
>> the driver that does the same as mpc8543-i2c.
> 
> Or you leave the driver as is and use both compatibles:
> 
> compatible = "fsl,qoriq-i2c", "fsl,mpc8543-i2c", "fsl-i2c";
> 
> ?
> 

I like Scott's proposition to add the prescaler in the device tree more. From
the hardware description point of view, it makes more sense: the devices are all
just fsl-i2c, with a different prescaler. I just quote it below as a reminder.

> 
> If we're going to change the device tree I'd rather just add a property
> to say what the prescaler is.

 We would however, leave the boards' device trees that use things like
"fsl,mpc8543-i2c" as is and introduce the prescaler for the others requiring it.


Now the drawback is that the driver would require a change, to parse this
prescaler new prescaler property. Would this be OK from your point of view
Wolfram ? If yes, I will send the patches for it.

Valentin
