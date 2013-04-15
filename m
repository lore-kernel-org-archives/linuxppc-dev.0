Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 03E832C00EC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Apr 2013 06:22:33 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Mon, 15 Apr 2013 16:22:28 -0400
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 224226E838C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2013 16:12:25 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3FKCRtu65142796
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2013 16:12:27 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3FKCPe1024912
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2013 16:12:25 -0400
Message-ID: <516C5F1B.9080308@linux.vnet.ibm.com>
Date: Mon, 15 Apr 2013 15:12:11 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH v2 2/11] Add PRRN Event Handler
References: <51509AE8.8070803@linux.vnet.ibm.com>
 <51509CF0.10200@linux.vnet.ibm.com> <20130410083012.GD24786@concordia>
In-Reply-To: <20130410083012.GD24786@concordia>
Content-Type: text/plain; charset=windows-1252
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/10/2013 03:30 AM, Michael Ellerman wrote:
> On Mon, Mar 25, 2013 at 01:52:32PM -0500, Nathan Fontenot wrote:
>> From: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
>>
>> A PRRN event is signaled via the RTAS event-scan mechanism, which
>> returns a Hot Plug Event message "fixed part" indicating "Platform
>> Resource Reassignment". In response to the Hot Plug Event message,
>> we must call ibm,update-nodes to determine which resources were
>> reassigned and then ibm,update-properties to obtain the new affinity
>> information about those resources.
> ..
> 
>> Index: powerpc/arch/powerpc/kernel/rtasd.c
>> ===================================================================
>> --- powerpc.orig/arch/powerpc/kernel/rtasd.c	2013-03-20 08:24:14.000000000 -0500
>> +++ powerpc/arch/powerpc/kernel/rtasd.c	2013-03-20 08:52:08.000000000 -0500
>> @@ -87,6 +87,8 @@
>>  			return "Resource Deallocation Event";
>>  		case RTAS_TYPE_DUMP:
>>  			return "Dump Notification Event";
>> +		case RTAS_TYPE_PRRN:
>> +			return "Platform Resource Reassignment Event";
>>  	}
>>  
>>  	return rtas_type[0];
>> @@ -265,7 +267,38 @@
>>  		spin_unlock_irqrestore(&rtasd_log_lock, s);
>>  		return;
>>  	}
>> +}
>> +
>> +static s32 update_scope;
>> +
>> +static void prrn_work_fn(struct work_struct *work)
>> +{
>> +	/*
>> +	 * For PRRN, we must pass the negative of the scope value in
>> +	 * the RTAS event.
>> +	 */
>> +	pseries_devicetree_update(-update_scope);
>> +}
>> +static DECLARE_WORK(prrn_work, prrn_work_fn);
> 
> This breaks the 32-bit build (ppc6xx_defconfig):
> 
> arch/powerpc/kernel/rtasd.c:280: undefined reference to `pseries_devicetree_update'
> 

I'm not seeing this error. rtasd.c compilkes fine, but I am hitting another
error later in the build that keeps it from finishing.

arch/powerpc/platforms/52xx/mpc52xx_pic.c: In function ‘mpc52xx_irqhost_map’:
arch/powerpc/platforms/52xx/mpc52xx_pic.c:343: error: ‘irqchip’ may be used uninitialized in this function


-Nathan 
