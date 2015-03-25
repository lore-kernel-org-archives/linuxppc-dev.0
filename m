Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8CCB41A0671
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 10:07:20 +1100 (AEDT)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Wed, 25 Mar 2015 19:07:17 -0400
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@fr.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/powernv: handle OPAL_SUCCESS return in
 opal_sensor_read
In-Reply-To: <1427305834-6737-1-git-send-email-clg@fr.ibm.com>
References: <1427305834-6737-1-git-send-email-clg@fr.ibm.com>
Date: Thu, 26 Mar 2015 10:07:10 +1100
Message-ID: <m3fv8s7k2p.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Neelesh Gupta <neelegup@linux.vnet.ibm.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@fr.ibm.com>, skiboot@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

C=C3=A9dric Le Goater <clg@fr.ibm.com> writes:
> Currently, when a sensor value is read, the kernel calls OPAL, which in
> turn builds a message for the FSP, and waits for a message back.=20
>
> The new device tree for OPAL sensors [1] adds new sensors that can be=20
> read synchronously (core temperatures for instance) and that don't need=20
> to wait for a response.
>
> This patch modifies the opal call to accept an OPAL_SUCCESS return value
> and cover the case above.
>
> [1] https://lists.ozlabs.org/pipermail/skiboot/2015-March/000639.html
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@fr.ibm.com>
> ---
>
>  We still uselessly reserve a token (for the response) and take a
>  lock, which might raise the need of a new 'opal_sensor_read_sync'=20
>  call.

Actually.... why do we take a lock around the OPAL calls at all?
