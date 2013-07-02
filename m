Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6254F2C008A
 for <linuxppc-dev@ozlabs.org>; Tue,  2 Jul 2013 18:56:46 +1000 (EST)
Message-ID: <1372755248.3616.5.camel@pasglop>
Subject: Re: [PATCH] Add hsize argument in write_buf call of pstore_ftrace_call
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Date: Tue, 02 Jul 2013 18:54:08 +1000
In-Reply-To: <20130702053611.11466.71343.stgit@aruna-ThinkPad-T420>
References: <20130702053611.11466.71343.stgit@aruna-ThinkPad-T420>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, fengguang.wu@intel.com,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org, kbuild-all@01.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-07-02 at 11:06 +0530, Aruna Balakrishnaiah wrote:
> Incorporate the addition of hsize argument in write_buf callback
> of pstore.

Thanks. I've added that to powerpc-next. It should hit Stephen tomorrow.

Cheers,
Ben.

> Signed-off-by: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
> ---
> 
>  fs/pstore/ftrace.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/pstore/ftrace.c b/fs/pstore/ftrace.c
> index 43b1280..76a4eeb 100644
> --- a/fs/pstore/ftrace.c
> +++ b/fs/pstore/ftrace.c
> @@ -44,7 +44,7 @@ static void notrace pstore_ftrace_call(unsigned long ip,
>  	rec.parent_ip = parent_ip;
>  	pstore_ftrace_encode_cpu(&rec, raw_smp_processor_id());
>  	psinfo->write_buf(PSTORE_TYPE_FTRACE, 0, NULL, 0, (void *)&rec,
> -			  sizeof(rec), psinfo);
> +			  0, sizeof(rec), psinfo);
>  
>  	local_irq_restore(flags);
>  }
