Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp03.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 335892C009A
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Aug 2013 01:33:03 +1000 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 8 Aug 2013 20:55:38 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 7DCB4394004D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Aug 2013 21:02:46 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r78FY7Hm35520740
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Aug 2013 21:04:07 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r78FWrLv026446
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Aug 2013 21:02:53 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>,
 Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 63/63] powerpc: Add pseries_le_defconfig
In-Reply-To: <20130807051618.GB19998@concordia>
References: <1375804940-22050-1-git-send-email-anton@samba.org>
 <1375804940-22050-64-git-send-email-anton@samba.org>
 <2419.1375831860@ale.ozlabs.ibm.com> <20130807051618.GB19998@concordia>
Date: Thu, 08 Aug 2013 21:02:52 +0530
Message-ID: <87r4e4p597.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <michael@ellerman.id.au> writes:

> On Wed, Aug 07, 2013 at 09:31:00AM +1000, Michael Neuling wrote:
>> Anton Blanchard <anton@samba.org> wrote:
>> 
>> > This is the pseries_defconfig with CONFIG_CPU_LITTLE_ENDIAN enabled
>> > and CONFIG_VIRTUALIZATION disabled (required until we fix some
>> > endian issues in KVM).
>> 
>> The CONFIG_VIRTUALIZATION disabling should be done in the Kconfig not
>> here. 
>> 
>> I'm not that keen on another defconfig.  benh is already talking about
>> having a powernv defconfig.  I'm worried we are going to fragment the
>> defconfigs.  If you want something special like LE, then change the
>> default one.  
>
> I disagree. defconfigs are great because they're easy to add to kisskb
> or other auto builders, making automated build testing easier.
>
> In fact because the defconfigs are pretty much the only thing that
> people build test, if you stray too far from them you are almost
> guaranteed to find breakage. For example the UP build was broken for
> months because we didn't have a defconfig for it.

This is true. My test build for patches mostly include 

for config in "....."
do
   make $config
   ....
done

-aneesh
