Return-Path: <linas@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 88FA7DDEAB
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 08:20:16 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l78MLUeh026296
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 18:21:30 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l78MKCWY376692
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 18:20:12 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l78MKBB3027217
	for <linuxppc-dev@ozlabs.org>; Wed, 8 Aug 2007 18:20:11 -0400
Date: Wed, 8 Aug 2007 17:20:11 -0500
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH 1/6] pseries: avoid excess rtas calls
Message-ID: <20070808222011.GG25995@austin.ibm.com>
References: <20070808195916.GA20055@austin.ibm.com>
	<20070808200115.GA20134@austin.ibm.com>
	<20070808215738.GC10114@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070808215738.GC10114@localdomain>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 08, 2007 at 04:57:39PM -0500, Nathan Lynch wrote:
> Linas Vepstas wrote:
> > 
> > We don't need to look up the rtas event token once per 
> > cpu per second. This avoids some misc string ops and 
> > rtas calls and provides some minor performance improvement.
> 
> It does not avoid any calls to RTAS.  (rtas_token merely looks up
> properties under the /rtas node.)

Right. I'd vaguely known but forgotten that of_get_property didn't 
actually turn into an rtas call.

> Otherwise, looks okay.

Should I resubmit with modified commit message, or does anyone care?

--linas
