Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17491.7435.783197.658219@cargo.ozlabs.ibm.com>
Date: Sat, 29 Apr 2006 18:00:11 +1000
From: Paul Mackerras <paulus@samba.org>
To: linas@austin.ibm.com (Linas Vepstas)
Subject: Re: [PATCH]: powerpc/pseries: Print PCI slot location code on failure
In-Reply-To: <20060428224218.GE22621@austin.ibm.com>
References: <20060428224218.GE22621@austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linas Vepstas writes:

> +		location = (char *) get_property(event->dn, "ibm,loc-code", NULL);
> +		printk(KERN_ERR "EEH: Error: Cannot find partition endpoint "
> +		                "for location=%s pci addr=%s\n",
> +		        location, pci_name(event->dev));

If location is NULL, printk will fortunately save us from a null
pointer dereference; still, it might be nice to have the message say
"location=unknown" or something rather than "location=<NULL>".

Paul.
