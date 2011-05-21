Return-Path: <dbaryshkov@gmail.com>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2A523B7210
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 22 May 2011 04:15:53 +1000 (EST)
Received: by vxi40 with SMTP id 40so3777188vxi.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 21 May 2011 11:15:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2825c3704d46eca735f20b01be7e33f9@kernel.crashing.org>
References: <1305973871-28244-1-git-send-email-dbaryshkov@gmail.com>
	<2825c3704d46eca735f20b01be7e33f9@kernel.crashing.org>
Date: Sat, 21 May 2011 22:15:50 +0400
Message-ID: <BANLkTinVURXfVwZq5G6B2kBj2b30p6n13A@mail.gmail.com>
Subject: Re: [PATCH 1/2] Maple: register CPC925 EDAC device on all boards with
	CPC925
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Harry Ciao <qingtao.cao@windriver.com>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 5/21/11, Segher Boessenkool <segher@kernel.crashing.org> wrote:
>> Currently Maple setup code creates cpc925_edac device only on
>> Motorola ATCA-6101 blade. Make setup code check bridge revision
>> and enable EDAC on all U3 bridges.
>
> But the EDAC code only works on U3H (CPC925), not old U3.

Ack, corrected. Thank you for the info.

>
>> +	if ((rev & 0xf0) != 0x30) { /* U3 */
>> +		printk(KERN_ERR "%s: Non-CPC925(U3) bridge revision: %02x\n",
>
> Should be:  if (rev >= 0x34 && rev <= 0x3f)
>
>
> Segher
>
>


-- 
With best wishes
Dmitry
