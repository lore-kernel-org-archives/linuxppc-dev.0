Message-ID: <40B485D3.7050703@fh-landshut.de>
Date: Wed, 26 May 2004 13:56:03 +0200
From: Oliver Korpilla <okorpil@fh-landshut.de>
MIME-Version: 1.0
To: "Heater, Daniel (GE Infrastructure)" <Daniel.Heater@gefanuc.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [Fwd: Memory layout question]
References: <DB1DE297F535B340AEAE1E51B221C3D0016B3DCB@FTWMLVEM02.e2k.ad.ge.com>
In-Reply-To: <DB1DE297F535B340AEAE1E51B221C3D0016B3DCB@FTWMLVEM02.e2k.ad.ge.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Below I sketched out a function that may give an address from the bus the Tundra
Universe is on - it is designed to be used, where normally the
allocate_resource() call is used (e.g. in create_slsi_window()).

With kind regards,
Oliver Korpilla

/* Try getting a resource (range of PCI addresses) from the PCI bus we're on */
static int allocate_pci_resource(unsigned long size, unsigned long align,
				 struct resource *new_resource) {

   /* Determine the bus the Tundra is on */
   struct pci_bus *bus = universe_pci_dev->bus;
   int i;

   for (i=0; i<4; i++) {
     int retval;

     /* Get one of the bus address ranges */
     struct resource *r = bus->resource[i];

     /* Check if that resource "exists" */
     if (!r)
       continue;

     /* If the resource is not I/O memory (e.g. I/O ports) */
     if (! (r->flags & IORESOURCE_MEM))
       continue;

#ifdef DEBUG
     /* Print out name of resource for debugging */
     if (r->name)
       printk(KERN_INFO "Checking bus resource with name \"%s\".\n", r->name);
     printk(KERN_INFO "resource.start: %08lX, resource.end: %08lX.\n",
	   r->start, r->end);
#endif

     /* Try to allocate a new sub-resource from this
        given the proper size and alignment*/
     retval = allocate_resource(r, new_resource, size, 0, ~0,
			       align, NULL, NULL);

     /* If this allocation fails, try with next resource
        (and give debug message) */
     if (retval < 0) {

#ifdef DEBUG
       if (r->name)
	printk(KERN_INFO
	       "Failed allocating from bus resource with name \"%s\".\n",
	       r->name);
       else
	printk(KERN_INFO
	       "Failed allocating from bus resource with number %d.\n", i);
#endif

       continue;
     }
     /* If this allocation succeeds, return what allocate_resource() returned */
     else
       return retval;
   }

   /* return busy if no resource could be successfully allocated */
   return -EBUSY;
}

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
