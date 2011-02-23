Return-Path: <jacmet@gmail.com>
Sender: Peter Korsgaard <jacmet@gmail.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC PATCH 07/15] dt: uartlite: merge platform and of_platform
	driver bindings
References: <20110223043015.20795.37090.stgit@localhost6.localdomain6>
	<20110223043411.20795.57850.stgit@localhost6.localdomain6>
Date: Wed, 23 Feb 2011 09:58:01 +0100
In-Reply-To: <20110223043411.20795.57850.stgit@localhost6.localdomain6> (Grant
	Likely's message of "Tue, 22 Feb 2011 21:34:11 -0700")
Message-ID: <877hcryvom.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sfr@canb.auug.org.au, devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>>>> "Grant" == Grant Likely <grant.likely@secretlab.ca> writes:

 Grant> of_platform_driver is getting removed, and a single platform_driver
 Grant> can now support both devicetree and non-devicetree use cases.  This
 Grant> patch merges the two driver registrations.

Wee!

 Grant>  static int __devinit ulite_probe(struct platform_device *pdev)
 Grant>  {
 Grant>  	struct resource *res, *res2;
 Grant> +	const __be32 *prop;
 Grant> +	int id = pdev->id;
 
 Grant>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 Grant>  	if (!res)
 Grant> @@ -583,7 +586,13 @@ static int __devinit ulite_probe(struct platform_device *pdev)
 Grant>  	if (!res2)
 Grant>  		return -ENODEV;
 
 Grant> -	return ulite_assign(&pdev->dev, pdev->id, res->start, res2->start);
 Grant> +#ifdef CONFIG_OF
 Grant> +	prop = of_get_property(pdev->dev.of_node, "port-number", NULL);
 Grant> +	if (prop)
 Grant> +		id = be32_to_cpup(prop);
 Grant> +#endif
 Grant> +
 Grant> +	return ulite_assign(&pdev->dev, id, res->start, res2->start);
 Grant>  }

Isn't this going to give a build warning about prop being unused on
!CONFIG_OF builds? Perhaps move it down into the CONFIG_OF conditional?

Other than that,

Acked-by: Peter Korsgaard <jacmet@sunsite.dk>

-- 
Bye, Peter Korsgaard
