Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18407.37606.990271.551578@cargo.ozlabs.ibm.com>
Date: Mon, 24 Mar 2008 22:39:18 +1100
From: Paul Mackerras <paulus@samba.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [RESEND] [PATCH 1/2 v2] [OF] Add of_device_is_available function
In-Reply-To: <20080301174825.57715d46@zod.rchland.ibm.com>
References: <20080301081600.74598ce4@zod.rchland.ibm.com>
	<20080301174825.57715d46@zod.rchland.ibm.com>
Cc: sfr@canb.auug.org.au, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer writes:

> This adds a function called of_device_is_available that checks the state
> of the status property of a device.  If the property is absent or set to
> either "okay" or "ok", it returns 1.  Otherwise it returns 0.

Well actually...

> +	if (statlen > 0) {
> +		if (!strncmp(status, "okay", 4) || !strncmp(status, "ok", 2))
> +			return 1;

The second test will succeed for anything that starts with "ok", so
the first test is redundant.  I suspect you want strcmp instead of
strncmp in both tests.

Paul.
