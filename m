Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A79711A001B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 09:28:50 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 14 May 2015 09:28:49 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 1DBE12CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 09:28:44 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4DNSZrO29819114
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 09:28:43 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4DNSA9u031182
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 09:28:11 +1000
Date: Thu, 14 May 2015 09:27:45 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH kernel v10 05/34] powerpc/iommu: Always release
 iommu_table in iommu_free_table()
Message-ID: <20150513232745.GA8158@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1431358763-24371-1-git-send-email-aik@ozlabs.ru>
 <1431358763-24371-6-git-send-email-aik@ozlabs.ru>
 <20150513053337.GA479@gwshan> <5552EF78.6020301@ozlabs.ru>
 <20150513145136.1a85f536@thh440s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150513145136.1a85f536@thh440s>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 13, 2015 at 02:51:36PM +0200, Thomas Huth wrote:
>On Wed, 13 May 2015 16:30:16 +1000
>Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>
>> On 05/13/2015 03:33 PM, Gavin Shan wrote:
>> > On Tue, May 12, 2015 at 01:38:54AM +1000, Alexey Kardashevskiy wrote:
>> >> At the moment iommu_free_table() only releases memory if
>> >> the table was initialized for the platform code use, i.e. it had
>> >> it_map initialized (which purpose is to track DMA memory space use).
>> >>
>> >> With dynamic DMA windows, we will need to be able to release
>> >> iommu_table even if it was used for VFIO in which case it_map is NULL
>> >> so does the patch.
>> >>
>> >> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> >
>> > Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> >
>> >> ---
>> >> arch/powerpc/kernel/iommu.c | 3 +--
>> >> 1 file changed, 1 insertion(+), 2 deletions(-)
>> >>
>> >> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
>> >> index 3d47eb3..2c02d4c 100644
>> >> --- a/arch/powerpc/kernel/iommu.c
>> >> +++ b/arch/powerpc/kernel/iommu.c
>> >> @@ -714,8 +714,7 @@ void iommu_free_table(struct iommu_table *tbl, const char *node_name)
>> >> 	unsigned int order;
>> >>
>> >> 	if (!tbl || !tbl->it_map) {
>> >> -		printk(KERN_ERR "%s: expected TCE map for %s\n", __func__,
>> >> -				node_name);
>> >> +		kfree(tbl);
>> >
>> > I'm not sure if the "tbl" needs to be checked against NULL as kfree() already
>> > has the check. But it looks a bit strange to free NULL "tbl" from the code
>> > itself.
>> 
>> Yeah, looks a bit weird, agree, I'll change but in general kfree/vfree/... 
>> - they all check the passed pointer for NULL.
>
>But if tbl is NULL, the tbl->it_map check will fail, won't it? So in
>this case, I think you have to keep it.
>

If I understood your question correctly, "tbl->it_map" won't be checked
when "tbl" is NULL because the connection ("||") for the two conditions.
The code can be changed to something like below if Alexey want:

	if (!tbl)
		return;
	if (!tbl->itmap)
		kfree(tbl);

Thanks,
Gavin
