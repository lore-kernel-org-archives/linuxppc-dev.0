Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18402.11542.346470.592333@cargo.ozlabs.ibm.com>
Date: Thu, 20 Mar 2008 20:23:34 +1100
From: Paul Mackerras <paulus@samba.org>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH 2/2] Force 4K IOPages when eHEA is present in the machine.
In-Reply-To: <20080320071858.GS4712@localdomain>
References: <63cdefde19cb2a4adc17ed771f21261673428ce7.1205987625.git.tony@bakeyournoodle.com>
	<262bc32afdde978922b9500c2a83f7c7ed6e4043.1205987625.git.tony@bakeyournoodle.com>
	<20080320071858.GS4712@localdomain>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	Jan-Bernd Themann <themann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Nathan Lynch writes:

> Searching ibm,drc-names is necessary, but is it sufficient?  That is,
> can there be a system that has an HEA adapter without that property
> being present?  Thinking in particular about single-partition systems
> that run without an HMC attached.

PAPR doesn't seem to say clearly one way or the other.  For 2.6.25,
the best thing is probably just to force 4k pages on all pSeries
machines.  Given that this is only for access to PCI devices, the
actual access is going to be slow enough that an extra TLB miss here
or there won't matter too much.

Paul.
