Return-Path: <anton@samba.org>
Date: Wed, 10 Aug 2011 21:28:03 +1000
From: Anton Blanchard <anton@samba.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 1/3] powerpc: numa: Remove double of_node_put in
	hot_add_node_scn_to_nid
Message-ID: <20110810212803.143fed4d@kryten>
In-Reply-To: <20110810183328.cfdfeec82b0d9eb0721687a8@canb.auug.org.au>
References: <20110810064937.424887717@samba.org>
	<20110810183328.cfdfeec82b0d9eb0721687a8@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Stephen,

> > Index: linux-powerpc/arch/powerpc/mm/numa.c
> > ===================================================================
> > --- linux-powerpc.orig/arch/powerpc/mm/numa.c	2011-06-06
> > 08:07:35.148708089 +1000 +++
> > linux-powerpc/arch/powerpc/mm/numa.c	2011-08-10
> > 11:31:59.723379868 +1000 @@ -1214,7 +1214,6 @@ int
> > hot_add_node_scn_to_nid(unsigned lon break; }
> >  
> > -		of_node_put(memory);
> >  		if (nid >= 0)
> >  			break;
> >  	}
> 
> Won't that need an of_node_put(memory) after the loop if (nid >=
> 0) ?  In fact you should be able to just move the of_node_put(memory)
> to after the loop since of_node_put(NULL) is fine.

Nice catch! Will respin the patch.

Anton
