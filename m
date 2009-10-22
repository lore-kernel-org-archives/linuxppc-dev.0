Return-Path: <nfont@austin.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e38.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E7E3DB7BB6
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Oct 2009 02:31:28 +1100 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e38.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9MFQwgS003739
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Oct 2009 09:26:58 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9MFVBRi122360
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Oct 2009 09:31:13 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id n9MFV6IM027653
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Oct 2009 09:31:07 -0600
Message-ID: <4AE07AB7.2070901@austin.ibm.com>
Date: Thu, 22 Oct 2009 10:31:03 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/5 v4] Export memory_sysdev_class
References: <4ADF1C49.2030201@austin.ibm.com>	
	<4ADF1E42.3020907@austin.ibm.com>
	<1256141009.23737.22.camel@nimitz>
In-Reply-To: <1256141009.23737.22.camel@nimitz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Dave Hansen wrote:
> On Wed, 2009-10-21 at 09:44 -0500, Nathan Fontenot wrote:
>> Export the memory_sysdev_class structure.  This is needed so we can create
>> a 'release' file in sysfs in addition to the existing 'probe' file in
>> order to support DLPAR removal of memory on the powerpc/pseries platform.
>> The new 'release' file will be powerpc/pseries only.
> 
> Please do it in generic code.  You may only need it on ppc today, but
> somebody else is going to want the same thing tomorrow on another arch.

I thought about this but wasn't sure if having the probe/release sysfs files
for memory and cpu be in generic code would be accepted.

Would it be acceptable to put the new release file for memory under the
ARCH_MEMORY_PROBE config option?  This would reduce the number of arch'es
that would require stubs as it appears only powerpc and x86 define this.

I could do the same thing for the cpu probe/release files and a new
ARCH_CPU_PROBE config option which would eliminate the required stubs
in arch'es other than powerpc right now.

-Nathan Fontenot
  
> 
> It's also nice to keep all of the stuff doing the actual sysfs munging
> in one place.  I know it'll cost a few stubs for calling in and out of
> arch code, but it should save some work down the road for somebody else.
> 
> -- Dave
> 
