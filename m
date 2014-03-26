Return-Path: <amodra@gmail.com>
Received: from mail-pd0-x22a.google.com (mail-pd0-x22a.google.com
 [IPv6:2607:f8b0:400e:c02::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CB61D14009A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Mar 2014 21:28:54 +1100 (EST)
Received: by mail-pd0-f170.google.com with SMTP id v10so1698344pde.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Mar 2014 03:28:51 -0700 (PDT)
Date: Wed, 26 Mar 2014 20:58:45 +1030
From: Alan Modra <amodra@gmail.com>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 27/33] powerpc: Handle new ELFv2 module relocations
Message-ID: <20140326102845.GP18201@bubble.grove.modra.org>
References: <1395747879-5948-1-git-send-email-anton@samba.org>
 <1395747879-5948-28-git-send-email-anton@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1395747879-5948-28-git-send-email-anton@samba.org>
Cc: mikey@neuling.org, rusty@rustcorp.com.au, ulrich.weigand@de.ibm.com,
 mjw@linux.vnet.ibm.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 25, 2014 at 10:44:33PM +1100, Anton Blanchard wrote:
> From: Rusty Russell <rusty@rustcorp.com.au>
> +		case R_PPC64_REL16_HA:
> +			/* Subtract location pointer */
> +			value -= (unsigned long)location;
> +			value = ((value + 0x8000) >> 16);
> +			*((uint16_t *) location)
> +				= (*((uint16_t *) location) & ~0xffff)
> +				| (value & 0xffff);

There's not much point reading the uint16_t.

			*(uint16_t *) location = value;

> +			break;
> +
> +		case R_PPC64_REL16_LO:
> +			/* Subtract location pointer */
> +			value -= (unsigned long)location;
> +			*((uint16_t *) location)
> +				= (*((uint16_t *) location) & ~0xffff)
> +				| (value & 0xffff);

and again.

> +			break;
> +
>  		default:
>  			printk("%s: Unknown ADD relocation: %lu\n",
>  			       me->name,

-- 
Alan Modra
Australia Development Lab, IBM
