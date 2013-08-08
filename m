Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6E6092C011A
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Aug 2013 23:20:03 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 8 Aug 2013 23:13:02 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 3A3CF2CE804C
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Aug 2013 23:19:54 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r78D430111010400
 for <linuxppc-dev@ozlabs.org>; Thu, 8 Aug 2013 23:04:03 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r78DJrxl007668
 for <linuxppc-dev@ozlabs.org>; Thu, 8 Aug 2013 23:19:53 +1000
Message-ID: <52039AF7.9080807@linux.vnet.ibm.com>
Date: Thu, 08 Aug 2013 18:49:51 +0530
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC PATCH 7/9] powerpc: Decode and save machine check event.
References: <20130807093609.5389.26534.stgit@mars.in.ibm.com>
 <20130807093913.5389.80206.stgit@mars.in.ibm.com>
 <20130808051422.GE12112@iris.ozlabs.ibm.com>
In-Reply-To: <20130808051422.GE12112@iris.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Jeremy Kerr <jeremy.kerr@au1.ibm.com>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/08/2013 10:44 AM, Paul Mackerras wrote:
> On Wed, Aug 07, 2013 at 03:09:13PM +0530, Mahesh J Salgaonkar wrote:
>> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>>
>> Now that we handle machine check in linux, the MCE decoding should also
>> take place in linux host. This info is crucial to log before we go down
>> in case we can not handle the machine check errors. This patch decodes
>> and populates a machine check event which contain high level meaning full
>> MCE information.
> 
> A couple of things worry me about this patch:
> 
> First, there is the fact that we can only do get_mce_event() once for
> a given machine check.  You call it in kvmppc_realmode_mc_power7(),
> which is fine, but if it is not something we recognize and can handle
> we will proceed to exit the guest and jump to machine_check_fwnmi,
> which will then proceed to machine_check_common() and then
> opal_machine_check(), where you have added another call to
> get_mce_event(), which will probably underflow your little per-cpu
> stack of machine check events.

Ouch! I missed that. Will work on fixing it.

> 
> Secondly, we shouldn't call save_mce_event() if we're not in
> hypervisor mode, since per-cpu variables are not in general accessible
> in real mode when running under a hypervisor with a limited real-mode
> area (RMA).

Does that mean in real mode we can never be able to access per cpu
variable? OR do I need to use some tweaks to access those?

Thanks,
-Mahesh.
