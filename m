Return-Path: <michael@ellerman.id.au>
Message-ID: <1342762410.15356.7.camel@concordia>
Subject: Re: [PATCH 3/4] powerpc/crypto: add 842 hardware compression driver
From: Michael Ellerman <michael@ellerman.id.au>
To: Seth Jennings <sjenning@linux.vnet.ibm.com>
Date: Fri, 20 Jul 2012 15:33:30 +1000
In-Reply-To: <1342708961-28587-4-git-send-email-sjenning@linux.vnet.ibm.com>
References: <1342708961-28587-1-git-send-email-sjenning@linux.vnet.ibm.com>
 <1342708961-28587-4-git-send-email-sjenning@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Robert Jennings <rcj@linux.vnet.ibm.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Kent Yoder <key@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>,
 linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-07-19 at 09:42 -0500, Seth Jennings wrote:
> This patch adds the driver for interacting with the 842
> compression accelerator on IBM Power7+ systems.

...

> +struct nx842_slentry {
> +	unsigned long ptr; /* Absolute address (use virt_to_abs()) */
> /+	unsigned long len;
> +};

These days virt_to_abs() is just __pa() - ie. convert to a real address.

So you should just use __pa().

And you also need to be certain that you only call it on addresses where
that makes sense, ie. not vmalloc etc.

cheers
