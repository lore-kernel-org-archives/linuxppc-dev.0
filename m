Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17613.33093.767856.432771@cargo.ozlabs.ibm.com>
Date: Mon, 31 Jul 2006 14:04:21 +1000
From: Paul Mackerras <paulus@samba.org>
To: Haren Myneni <haren@us.ibm.com>
Subject: Re: [PATCH] Add rtas_set_indicator_fast() for RTAS call without
	extended delay
In-Reply-To: <44C9301C.7080300@us.ibm.com>
References: <44C6F521.8040609@us.ibm.com> <20060726220441.GZ19076@localdomain>
	<44C9301C.7080300@us.ibm.com>
Cc: External List <linuxppc-dev@ozlabs.org>, Nathan Lynch <ntl@pobox.com>,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Haren Myneni writes:

> +	WARN_ON(rc == -2 || (rc >= 9900 && rc <= 9905));

This worries me... do we know for sure that RTAS will never return a
busy code?  If it could possibly return a busy code, and we can't
sleep, then we should spin doing the call again and again until it
works, I think.

Paul.
