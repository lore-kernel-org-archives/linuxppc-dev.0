Return-Path: <mb@bu3sch.de>
Received: from vs166246.vserver.de (bu3sch.de [62.75.166.246])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5AF72B7BCF
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 27 Oct 2009 06:30:37 +1100 (EST)
From: Michael Buesch <mb@bu3sch.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: Network Stack SKB Reallocation
Date: Mon, 26 Oct 2009 20:13:50 +0100
References: <BB99A6BA28709744BF22A68E6D7EB51F0330BEB38D@midas.usurf.usu.edu>
In-Reply-To: <BB99A6BA28709744BF22A68E6D7EB51F0330BEB38D@midas.usurf.usu.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200910262013.52458.mb@bu3sch.de>
Cc: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday 26 October 2009 19:43:00 Jonathan Haws wrote:
> Quick question about the network stack in general:
> 
> Does the stack itself release an SKB allocated by the device driver back to the heap upstream, or does it require that the device driver handle that?

There's the concept of passing responsibilities for the frames between
the networking layers. So the driver passes the frame and all responsibilities
to the networking stack. So if the networking stack accepts the packet in the first place,
it needs to free it (or pass it to somebody else to take care of).

-- 
Greetings, Michael.
