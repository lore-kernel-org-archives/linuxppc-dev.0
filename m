Return-Path: <dan.j.williams@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by ozlabs.org (Postfix) with ESMTP id D74FFDE1D7
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 12:06:32 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m33so652901wag.9
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2009 17:06:31 -0800 (PST)
Message-ID: <e9c3a7c20901141706v17215220s22d973f81369be72@mail.gmail.com>
Date: Wed, 14 Jan 2009 18:06:31 -0700
From: "Dan Williams" <dan.j.williams@intel.com>
Sender: dan.j.williams@gmail.com
To: "Yuri Tikhonov" <yur@emcraft.com>
Subject: Re: [PATCH 03/11][v3] async_tx: add support for asynchronous RAID6
	recovery operations
In-Reply-To: <200901130343.14016.yur@emcraft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200901130343.14016.yur@emcraft.com>
Cc: linux-raid@vger.kernel.org, linuxppc-dev@ozlabs.org, wd@denx.de,
	dzu@denx.de, yanok@emcraft.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 12, 2009 at 5:43 PM, Yuri Tikhonov <yur@emcraft.com> wrote:
> +       /* (2) Calculate Q+Qxy */
> +       lptrs[0] = ptrs[failb];
> +       lptrs[1] = ptrs[disks-1];
> +       lptrs[2] = NULL;
> +       tx = async_pq(lptrs, NULL, 0, 1, bytes, ASYNC_TX_DEP_ACK,
> +                     tx, NULL, NULL);
> +
> +       /* (3) Calculate P+Pxy */
> +       lptrs[0] = ptrs[faila];
> +       lptrs[1] = ptrs[disks-2];
> +       lptrs[2] = NULL;
> +       tx = async_pq(lptrs, NULL, 0, 1, bytes, ASYNC_TX_DEP_ACK,
> +                     tx, NULL, NULL);
> +

These two calls convinced me that ASYNC_TX_PQ_ZERO_{P,Q} need to go.
A 1-source async_pq operation does not make sense.  These should be:

       /* (2) Calculate Q+Qxy */
       lptrs[0] = ptrs[disks-1];
       lptrs[1] = ptrs[failb];
       tx = async_xor(lptrs[0], lptrs, 0, 2, bytes,
                      ASYNC_TX_XOR_DROP_DST|ASYNC_TX_DEP_ACK, tx, NULL, NULL);

        /* (3) Calculate P+Pxy */
       lptrs[0] = ptrs[disks-2];
       lptrs[1] = ptrs[faila];
       tx = async_xor(lptrs[0], lptrs, 0, 2, bytes,
                      ASYNC_TX_XOR_DROP_DST|ASYNC_TX_DEP_ACK, tx, NULL, NULL);

Regards,
Dan
