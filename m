Return-Path: <stephen@networkplumber.org>
Received: from mail-pf0-x235.google.com (mail-pf0-x235.google.com
 [IPv6:2607:f8b0:400e:c00::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v8Vlw40x0zDq6l
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2017 05:28:12 +1100 (AEDT)
Received: by mail-pf0-x235.google.com with SMTP id 189so67105943pfu.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2017 10:28:12 -0800 (PST)
Date: Thu, 26 Jan 2017 10:28:02 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 wvoigt@us.ibm.com, nfont@linux.vnet.ibm.com, jallen@linux.vnet.ibm.com
Subject: Re: [PATCH net 1/5] ibmvnic: harden interrupt handler
Message-ID: <20170126102802.4f920418@xeon-e3>
In-Reply-To: <1485378143-5084-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
References: <1485378143-5084-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 25 Jan 2017 15:02:19 -0600
Thomas Falcon <tlfalcon@linux.vnet.ibm.com> wrote:

>  static irqreturn_t ibmvnic_interrupt(int irq, void *instance)
>  {
>  	struct ibmvnic_adapter *adapter = instance;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&adapter->crq.lock, flags);
> +	vio_disable_interrupts(adapter->vdev);
> +	tasklet_schedule(&adapter->tasklet);
> +	spin_unlock_irqrestore(&adapter->crq.lock, flags);
> +	return IRQ_HANDLED;
> +}
> +

Why not use NAPI? rather than a tasklet
