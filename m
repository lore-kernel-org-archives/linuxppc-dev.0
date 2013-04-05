Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 084872C00F3
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Apr 2013 05:03:23 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Fri, 5 Apr 2013 14:03:18 -0400
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id ADDC9C90049
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2013 14:02:59 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r35I2xwe204354
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Apr 2013 14:02:59 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r35I2x78019443
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Apr 2013 15:02:59 -0300
Message-ID: <515F11D2.5070900@linux.vnet.ibm.com>
Date: Fri, 05 Apr 2013 13:02:58 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2 6/11] Update CPU Maps
References: <51509AE8.8070803@linux.vnet.ibm.com>
 <51509E04.9000709@linux.vnet.ibm.com> <20130404044240.GG19443@drongo>
In-Reply-To: <20130404044240.GG19443@drongo>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/03/2013 11:42 PM, Paul Mackerras wrote:
> On Mon, Mar 25, 2013 at 01:57:08PM -0500, Nathan Fontenot wrote:
>> From: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
>>
>> Platform events such as partition migration or the new PRRN firmware
>> feature can cause the NUMA characteristics of a CPU to change, and these
>> changes will be reflected in the device tree nodes for the affected
>> CPUs.
>>
>> This patch registers a handler for Open Firmware device tree updates
>> and reconfigures the CPU and node maps whenever the associativity
>> changes. Currently, this is accomplished by marking the affected CPUs in
>> the cpu_associativity_changes_mask and allowing
>> arch_update_cpu_topology() to retrieve the new associativity information
>> using hcall_vphn().
>>
>> Protecting the NUMA cpu maps from concurrent access during an update
>> operation will be addressed in a subsequent patch in this series.
>>
>> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> 
> [snip]
> 
>> +	if (firmware_has_feature(OV5_PRRN)) {
> 
> Shouldn't this be FW_FEATURE_PRRN?  How well has this patch been
> tested? :-/

Yes this should have been FW_FEATURE_PRRN.

I know I tested this and it took some digging to find out why my test succeeded
even though I used the wrong value in the call to firmware_has_feature. The value
for OV5_PRRN (0x0540) just happens to match some of he bits that are set in
powerpc_firmware_features bit field and cause the check to return true. My test
worked out of sheer luck. I'll update this patch and re-test to ensure it works
with the real value.

This does make me think, should we update firmware_has_feature() to avoid this
kind of false positive in the future. something like

#define firmware_has_feature(feature)                                              \
        ((FW_FEATURE_ALWAYS & (feature)) == (feature) ||                           \
         (FW_FEATURE_POSSIBLE & powerpc_firmware_features & (feature)) == (feature)

-Nathan
