Return-Path: <micha@neli.hopto.org>
Received: from edu-smtp-02.edutel.nl (edu-smtp-02.edutel.nl [88.159.1.176])
	by ozlabs.org (Postfix) with ESMTP id E5772B70CC
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 26 Oct 2010 07:07:02 +1100 (EST)
Message-ID: <4CC5E354.80009@neli.hopto.org>
Date: Mon, 25 Oct 2010 22:06:44 +0200
From: Micha Nelissen <micha@neli.hopto.org>
MIME-Version: 1.0
To: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
Subject: Re: [PATCH -mm 0/2] RapidIO: Changes to handling of RIO switches
References: <1287688250-14226-1-git-send-email-alexandre.bounine@idt.com>
	<4CC0AD74.8070800@neli.hopto.org>
	<0CE8B6BE3C4AD74AB97D9D29BD24E55201445906@CORPEXCH1.na.ads.idt.com>
	<4CC1D7DE.7060405@neli.hopto.org>
	<0CE8B6BE3C4AD74AB97D9D29BD24E55201445A6B@CORPEXCH1.na.ads.idt.com>
	<4CC20923.8050400@neli.hopto.org>
	<0CE8B6BE3C4AD74AB97D9D29BD24E55201445BA4@CORPEXCH1.na.ads.idt.com>
	<4CC5ACAB.7070309@neli.hopto.org>
	<0CE8B6BE3C4AD74AB97D9D29BD24E5520147D5C2@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <0CE8B6BE3C4AD74AB97D9D29BD24E5520147D5C2@CORPEXCH1.na.ads.idt.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-kernel@vger.kernel.org, Thomas Moll <thomas.moll@sysgo.com>,
	akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Bounine, Alexandre wrote:
> Micha Nelissen <micha@neli.hopto.org> wrote:
>> that switch. The tag uses one extra bit to identify the device as a
>> switch instead of an endpoint. This provides the information to
>> unambiguously identify a switch from an endpoint.
> 
> OK taking away #2. But do not see how it justifies storing two values of
> destid.

I look at it this way: it prevents the need for another layer of 
indirection: translating component tag to a destid.

> And you have just confirmed using CT for unique identification. 

That's correct, but I never said (intended to say) I didn't.

> We
> simply have differences in interpretation of CT: you are using component
> tag to pass unique identification and I am using CT as a unique
> identification. I prefer not to assume any relationship between routing
> information and the component tag.

Why no relation? My experience is that during debugging it's useful to 
have the destid directly at hand, it's just very practical. (Otherwise 
any drawing of a random network would need two "identification" numbers 
per drawn node: the component tag (true identification), and destid 
since that's what everyone uses to identify a device, what needs to 
programmed into the LUTs of a switch, identification in sysfs, etc.).

Micha
