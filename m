Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12]) by ozlabs.org (Postfix) with ESMTP id 0A3BE2C0084
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jan 2014 07:27:57 +1100 (EST)
Date: Wed, 8 Jan 2014 12:28:26 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH RFC 1/3] drivers: base: support cpu cache information
 interface to userspace via sysfs
Message-ID: <20140108202826.GF8417@kroah.com>
References: <1389209168-17189-1-git-send-email-sudeep.holla@arm.com>
 <1389209168-17189-2-git-send-email-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1389209168-17189-2-git-send-email-sudeep.holla@arm.com>
Cc: devicetree@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>,
 Rob Herring <robh@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 08, 2014 at 07:26:06PM +0000, Sudeep Holla wrote:
> From: Sudeep Holla <sudeep.holla@arm.com>
> +#define define_one_ro(_name) \
> +static struct cache_attr _name = \
> +	__ATTR(_name, 0444, show_##_name, NULL)

In the future, we do have __ATTR_RO(), which should be used instead.
You should never use __ATTR() on it's own, if at all possible.  I'm
sweeping the tree for all usages and fixing them slowly up over time.

thanks,

greg k-h
