Return-Path: <ericvh@gmail.com>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 90DB01007D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 22:53:39 +1000 (EST)
Received: by bwz10 with SMTP id 10so2630943bwz.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 05:53:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110519104330.GA25179@zod.rchland.ibm.com>
References: <1305753895-24845-1-git-send-email-ericvh@gmail.com>
	<1305753895-24845-4-git-send-email-ericvh@gmail.com>
	<20110519104330.GA25179@zod.rchland.ibm.com>
Date: Thu, 19 May 2011 07:53:34 -0500
Message-ID: <BANLkTinyhUiEfE4R7a4WyXSy6ZYNSimZcA@mail.gmail.com>
Subject: Re: [PATCH 4/7] [RFC] enable L1_WRITETHROUGH mode for BG/P
From: Eric Van Hensbergen <ericvh@gmail.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	bg-linux@lists.anl-external.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 19, 2011 at 5:43 AM, Josh Boyer <jwboyer@linux.vnet.ibm.com> wr=
ote:
> On Wed, May 18, 2011 at 04:24:52PM -0500, Eric Van Hensbergen wrote:
>>
>>+config L1_WRITETHROUGH
>>+ =A0 =A0 =A0bool "Blue Gene/P enabled writethrough mode"
>>+ =A0 =A0 =A0depends on BGP
>>+ =A0 =A0 =A0default y
>
> You add this config option here, named generically, but then make it
> depend on BGP. =A0It sees it should be named BGP_L1_WRITETHROUGH, and the=
n
> just selected by the BGP platform. =A0But then....
>
>> endmenu
>>diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platfo=
rms/Kconfig.cputype
>>index 111138c..3a3c711 100644
>>--- a/arch/powerpc/platforms/Kconfig.cputype
>>+++ b/arch/powerpc/platforms/Kconfig.cputype
>>@@ -329,9 +329,13 @@ config NOT_COHERENT_CACHE
>> =A0 =A0 =A0 bool
>> =A0 =A0 =A0 depends on 4xx || 8xx || E200 || PPC_MPC512x || GAMECUBE_COM=
MON
>> =A0 =A0 =A0 default n if PPC_47x
>>+ =A0 =A0 =A0default n if BGP
>> =A0 =A0 =A0 default y
>>
>> config CHECK_CACHE_COHERENCY
>> =A0 =A0 =A0 bool
>>
>>+config L1_WRITETHROUGH
>>+ =A0 =A0 =A0bool
>
> You add an identical option down here. =A0Confused.
>

Yeah, this was copied from the original patches and it confused me as
well, but I had never
modified Kconfig.cputype before so I wasn't sure if there were some
weird rules.  I'm happy
to remove the vestigial one and make the changes you suggest to make
the naming BGP
specific.

         -eric
