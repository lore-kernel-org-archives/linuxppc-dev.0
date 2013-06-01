Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5D0112C00A7
 for <linuxppc-dev@ozlabs.org>; Sat,  1 Jun 2013 14:53:07 +1000 (EST)
Message-ID: <1370062367.3766.30.camel@pasglop>
Subject: Re: [PATCH v3 8/8] powerpc/pseries: Read common partition via pstore
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Aruna Balakrishnaiah <aruna@linux.vnet.ibm.com>
Date: Sat, 01 Jun 2013 14:52:47 +1000
In-Reply-To: <20130425101908.21017.32553.stgit@aruna-ThinkPad-T420>
References: <20130425100952.21017.51799.stgit@aruna-ThinkPad-T420>
 <20130425101908.21017.32553.stgit@aruna-ThinkPad-T420>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: jkenisto@linux.vnet.ibm.com, tony.luck@intel.com, mahesh@linux.vnet.ibm.com,
 cbouatmailru@gmail.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
 paulus@samba.org, anton@samba.org, ccross@android.com, keescook@chromium.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-04-25 at 15:49 +0530, Aruna Balakrishnaiah wrote:

> diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
> index 8d4fb65..88cc050 100644
> --- a/fs/pstore/inode.c
> +++ b/fs/pstore/inode.c
> @@ -330,6 +330,9 @@ int pstore_mkfile(enum pstore_type_id type, char *psname, u64 id, int count,
>  	case PSTORE_TYPE_PPC_OF:
>  		sprintf(name, "of-%s-%lld", psname, id);
>  		break;

Call this powerpc-ofw-... Does it even contain something we use in Linux
at all ? Last I looked we only used the common one right ? Also it's
format afaik is defined in the CHRP bindings so it's not generic OFW
stuff, hence the powerpc prefix.

> +	case PSTORE_TYPE_PPC_COMMON:
> +		sprintf(name, "common-%s-%lld", psname, id);
> +		break;

Same deal, call that powerpc-common

>  	case PSTORE_TYPE_UNKNOWN:
>  		sprintf(name, "unknown-%s-%lld", psname, id);
>  		break;
> diff --git a/include/linux/pstore.h b/include/linux/pstore.h
> index 615dc18..656699f 100644
> --- a/include/linux/pstore.h
> +++ b/include/linux/pstore.h
> @@ -38,6 +38,7 @@ enum pstore_type_id {
>  	/* PPC64 partition types */
>  	PSTORE_TYPE_PPC_RTAS	= 4,
>  	PSTORE_TYPE_PPC_OF	= 5,
> +	PSTORE_TYPE_PPC_COMMON	= 6,
>  	PSTORE_TYPE_UNKNOWN	= 255
>  };

Do we expose anything else or keep it hidden ?

Cheers,
Ben.
