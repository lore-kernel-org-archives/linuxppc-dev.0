Reply-To: <acurtis@onz.com>
From: "Allen Curtis" <acurtis@onz.com>
To: "Paul Mackerras" <paulus@samba.org>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: RE: eieio rule-of-thumb?
Date: Thu, 23 May 2002 06:38:24 -0700
Message-ID: <NCBBIINEHIPFGJPLBEIFAEIBDHAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <15596.28533.954307.94549@argo.ozlabs.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> For access to PCI devices, use:
>
> {in,out}{b,w,l}		access to PCI I/O space (little endian)
> {read,write}{b,w,l}	access to PCI memory space (little endian)
>
> For access to non-PCI devices on PPC platforms, use:
>
> {in,out}_8
> {in,out}_{le,be}{16,32}
>

All of these make sense, but what about the Internal Memory Map? Are you
suggesting that these macros should be used to access internal control
structures, buffer descriptors, etc and ignore the structures defined in
cpm_8260.h and imap_8260.h? In a typical system, this is where most of the
non-cacheable I/O will occur. In many cases you probably do not care what
order things happen at the micro level, in some cases you do. If you
understand the problem you can optimize your solution, otherwise put the fix
everywhere out of paranoia.  :)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
