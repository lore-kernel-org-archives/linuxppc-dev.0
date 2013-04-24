Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp07.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 101EB2C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 16:29:21 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Wed, 24 Apr 2013 16:19:31 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id C42FD2BB0051
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 16:28:18 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3O6SCJJ28377336
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 16:28:12 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3O6SHM9004456
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 16:28:17 +1000
Message-ID: <51777B74.8040204@linux.vnet.ibm.com>
Date: Wed, 24 Apr 2013 11:58:04 +0530
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH] PowerPC: kernel: memory access violation when
 rtas_data_buf contents are more than 1026
References: <516F7A7D.60206@asianux.com> <1366677081.2886.7.camel@pasglop>
 <5175E85F.1040509@asianux.com> <5175FC36.4060308@asianux.com>
In-Reply-To: <5175FC36.4060308@asianux.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "paulus@samba.org" <paulus@samba.org>, Al Viro <viro@zeniv.linux.org.uk>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/23/2013 08:42 AM, Chen Gang wrote:
>
> need set '\0' for 'local_buffer'.
>
> SPLPAR_MAXLENGTH is 1026, RTAS_DATA_BUF_SIZE is 4096. so the contents of
> rtas_data_buf may truncated in memcpy.
>
> if contents are really truncated.
>    the splpar_strlen is more than 1026. the next while loop checking will
>    not find the end of buffer. that will cause memory access violation.
>

Per parameter length in ibm,get-system-parameter RTAS call is limited to 1026 
bytes (1024 bytes of data + 2 bytes  length). And 'rtas_data_buf' was set to 0 
(first 1026 bytes) before call RTAS call. At the worst if we get junk in RTAS 
output length field helps to exit from the while loop. So I don't think we need 
this patch.

-Vasant

>
> Signed-off-by: Chen Gang<gang.chen@asianux.com>
> ---
>   arch/powerpc/kernel/lparcfg.c |    1 +
>   1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/kernel/lparcfg.c b/arch/powerpc/kernel/lparcfg.c
> index 801a757..d92f387 100644
> --- a/arch/powerpc/kernel/lparcfg.c
> +++ b/arch/powerpc/kernel/lparcfg.c
> @@ -299,6 +299,7 @@ static void parse_system_parameter_string(struct seq_file *m)
>   				__pa(rtas_data_buf),
>   				RTAS_DATA_BUF_SIZE);
>   	memcpy(local_buffer, rtas_data_buf, SPLPAR_MAXLENGTH);
> +	local_buffer[SPLPAR_MAXLENGTH - 1] = '\0';
>   	spin_unlock(&rtas_data_buf_lock);
>
>   	if (call_status != 0) {
