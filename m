Return-Path: <anton@samba.org>
Date: Wed, 23 Apr 2014 07:31:15 +1000
From: Anton Blanchard <anton@samba.org>
To: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Subject: Re: [PATCH 6/6] powerpc/powernv: Fix little endian issues in OPAL
 dump code
Message-ID: <20140423073115.6a7d4802@kryten>
In-Reply-To: <53562921.6050300@linux.vnet.ibm.com>
References: <1398142887-24109-1-git-send-email-anton@samba.org>
 <1398142887-24109-6-git-send-email-anton@samba.org>
 <53562921.6050300@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: stewart@linux.vnet.ibm.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

> -int64_t opal_dump_info(uint32_t *dump_id, uint32_t *dump_size);
> -int64_t opal_dump_info2(uint32_t *dump_id, uint32_t *dump_size, uint32_t *dump_type);
> +int64_t opal_dump_info(__be32 *dump_id, __be32 *dump_size);
> +int64_t opal_dump_info2(__be32 *dump_id, __be32 *dump_size, __be32 *dump_type);
>  int64_t opal_dump_read(uint32_t dump_id, uint64_t buffer);
>  int64_t opal_dump_ack(uint32_t dump_id);  
>
> Shouldn't we change above two functions as well ?

No, there are no endian issues here because we pass the values via
register. The only endian issues are for values we pass via pointer.

> Should we convert ID back to BE format in dump_send_ack()  ?

Same as above.

Anton
