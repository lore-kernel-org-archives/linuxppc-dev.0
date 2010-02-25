Return-Path: <micha@neli.hopto.org>
Received: from edu-smtp-02.edutel.nl (edu-smtp-02.edutel.nl [88.159.1.222])
	by ozlabs.org (Postfix) with ESMTP id 90A30B7CB6
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 26 Feb 2010 06:11:20 +1100 (EST)
Received: from neli.hopto.org (unknown [88.159.215.98])
	by edu-smtp-02.edutel.nl (Postfix) with ESMTP id 27481121E08
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 25 Feb 2010 20:11:18 +0100 (CET)
Received: from conroe.local ([90.0.0.126] ident=micha)
	by neli.hopto.org with esmtp (Exim 4.69)
	(envelope-from <micha@neli.hopto.org>) id 1Nkj7F-0008Ug-Kq
	for linuxppc-dev@lists.ozlabs.org; Thu, 25 Feb 2010 20:11:17 +0100
Message-ID: <4B86CB4C.2070406@neli.hopto.org>
Date: Thu, 25 Feb 2010 20:11:08 +0100
From: Micha Nelissen <micha@neli.hopto.org>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/7] RapidIO: Add switch locking during discovery
References: <20100224152050.GB13661@kaneng01.tundra.com>
	<4B857A53.30106@neli.hopto.org>
	<0CE8B6BE3C4AD74AB97D9D29BD24E552A54EA1@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <0CE8B6BE3C4AD74AB97D9D29BD24E552A54EA1@CORPEXCH1.na.ads.idt.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Bounine, Alexandre wrote:
> Micha Nelissen wrote:
>> Alexandre Bounine wrote:
>>> +		mport->host_deviceid = RIO_GET_DID(mport->sys_size,
>> This fixes something else, should be a separate patch.
> 
> This sets an ID used for locking during discovery. On a startup only
> enumerator's ID is set to the specified value. All discovering agents

Ah I see. Isn't it a bit ugly to have "host_deviceid" being the device's
own destid?

I have removed mport->host_deviceid, and added rdev_host and rdev_self
to rio_net. I also added code to create a rio device for the "self"
instance; then the locking would always use net->rdev_self->destid.

Micha
