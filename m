Return-Path: <ebs@ebshome.net>
Date: Thu, 24 Feb 2005 20:20:52 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: "Howard, Marc" <Marc.Howard@KLA-Tencor.com>
Message-ID: <20050225042052.GA12703@gate.ebshome.net>
References: <91B22F93A880FA48879475E134D6F0BE8E7CB9@CA1EXCLV02.adcorp.kla-tencor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <91B22F93A880FA48879475E134D6F0BE8E7CB9@CA1EXCLV02.adcorp.kla-tencor.com>
Cc: Linuxppc-embedded@ozlabs.org
Subject: Re: Gigibit ethernet ports on Ocotea + 2.6.10
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Feb 24, 2005 at 06:42:40PM -0800, Howard, Marc wrote:
> console=ttyS0,115200 root=/dev/nfs rw
> nfsroot=192.168.168.108:/projects/targets/ppc_4xx
> ip=192.168.168.111:192.168.168.108:192.168.168.108:255.255.255.0:ppc440:
> :off

You haven't searched archives very hard :). 

Format of ip=... can be found in net/ipv4/ipconfig.c:

/*
 *  Decode any IP configuration options in the "ip=" or "nfsaddrs=" kernel
 *  command line parameter. It consists of option fields separated by colons in
 *  the following order:
 *
 *  <client-ip>:<server-ip>:<gw-ip>:<netmask>:<host name>:<device>:<PROTO>
 *
 *  Any of the fields can be empty which means to use a default value:
 *      <client-ip>     - address given by BOOTP or RARP
 *      <server-ip>     - address of host returning BOOTP or RARP packet
 *      <gw-ip>         - none, or the address returned by BOOTP
 *      <netmask>       - automatically determined from <client-ip>, or the
 *                        one returned by BOOTP
 *      <host name>     - <client-ip> in ASCII notation, or the name returned
 *                        by BOOTP
 *      <device>        - use all available devices
 *      <PROTO>:
 *         off|none         - don't do autoconfig at all (DEFAULT)
 *         on|any           - use any configured protocol
 *         dhcp|bootp|rarp  - use only the specified protocol
 *         both             - use both BOOTP and RARP (not DHCP)
 */


BTW, looks like your ip=.. line is incorrect, you missed <device> 
parameter.

--
Eugene
