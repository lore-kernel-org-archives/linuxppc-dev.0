Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yVdMz3T3tzDqlM
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Nov 2017 14:29:35 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vA63OLfC013098
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 5 Nov 2017 22:29:33 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2e2c5effun-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Nov 2017 22:29:32 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Mon, 6 Nov 2017 03:29:30 -0000
Subject: Re: [PATCH] powerpc: eeh: stop using do_gettimeofday()
To: Arnd Bergmann <arnd@arndb.de>, Russell Currey <ruscur@russell.cc>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
 Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
References: <20171104212727.3228606-1-arnd@arndb.de>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Mon, 6 Nov 2017 14:29:23 +1100
MIME-Version: 1.0
In-Reply-To: <20171104212727.3228606-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <6c73bf01-d16e-da63-d464-45d0494a3ee7@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/11/17 08:26, Arnd Bergmann wrote:
> This interface is inefficient and deprecated because of the y2038
> overflow.
> 
> ktime_get_seconds() is an appropriate replacement here, since it
> has sufficient granularity but is more efficient and uses monotonic
> time.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> ---
>   arch/powerpc/include/asm/eeh.h   | 2 +-
>   arch/powerpc/kernel/eeh_driver.c | 2 +-
>   arch/powerpc/kernel/eeh_pe.c     | 8 ++++----
>   3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
> index cd1df96335e5..5161c37dd039 100644
> --- a/arch/powerpc/include/asm/eeh.h
> +++ b/arch/powerpc/include/asm/eeh.h
> @@ -93,7 +93,7 @@ struct eeh_pe {
>   	struct pci_bus *bus;		/* Top PCI bus for bus PE	*/
>   	int check_count;		/* Times of ignored error	*/
>   	int freeze_count;		/* Times of froze up		*/
> -	struct timeval tstamp;		/* Time on first-time freeze	*/
> +	time64_t tstamp;		/* Time on first-time freeze	*/
>   	int false_positives;		/* Times of reported #ff's	*/
>   	atomic_t pass_dev_cnt;		/* Count of passed through devs	*/
>   	struct eeh_pe *parent;		/* Parent PE			*/
> diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
> index 4e1b433f6cb5..4f71e4c9beb7 100644
> --- a/arch/powerpc/kernel/eeh_driver.c
> +++ b/arch/powerpc/kernel/eeh_driver.c
> @@ -623,7 +623,7 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
>   				struct eeh_rmv_data *rmv_data)
>   {
>   	struct pci_bus *frozen_bus = eeh_pe_bus_get(pe);
> -	struct timeval tstamp;
> +	time64_t tstamp;
>   	int cnt, rc;
>   	struct eeh_dev *edev;
>   
> diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
> index 2e8d1b2b5af4..2d4956e97aa9 100644
> --- a/arch/powerpc/kernel/eeh_pe.c
> +++ b/arch/powerpc/kernel/eeh_pe.c
> @@ -526,16 +526,16 @@ int eeh_rmv_from_parent_pe(struct eeh_dev *edev)
>    */
>   void eeh_pe_update_time_stamp(struct eeh_pe *pe)
>   {
> -	struct timeval tstamp;
> +	time64_t tstamp;
>   
>   	if (!pe) return;
>   
>   	if (pe->freeze_count <= 0) {
>   		pe->freeze_count = 0;
> -		do_gettimeofday(&pe->tstamp);
> +		pe->tstamp = ktime_get_seconds();
>   	} else {
> -		do_gettimeofday(&tstamp);
> -		if (tstamp.tv_sec - pe->tstamp.tv_sec > 3600) {
> +		tstamp = ktime_get_seconds();
> +		if (tstamp - pe->tstamp > 3600) {
>   			pe->tstamp = tstamp;
>   			pe->freeze_count = 0;
>   		}
> 

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
