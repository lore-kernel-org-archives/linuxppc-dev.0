Date: Sun, 24 Sep 2000 20:00:05 -0600
From: Cort Dougan <cort@fsmlabs.com>
To: Benjamin Herrenschmidt <bh40@calva.net>
Cc: linuxppc-dev@lists.linuxppc.org, Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Mackerras <paulus@linuxcare.com.au>
Subject: Re: PCI rework & CHRP question
Message-ID: <20000924200005.E20496@hq.fsmlabs.com>
References: <19340818162914.6020@192.168.1.10>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <19340818162914.6020@192.168.1.10>; from Benjamin Herrenschmidt on Sun, Sep 24, 2000 at 12:57:30AM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


} I'm working on a rework of our arch/pci.c (to properly handle multiple
} host bridges, and various other cleanups).
}
} In the chrp_pci.c code, I found this code:
}
}         if ( !strncmp("MOT",
}                       get_property(find_path_device("/"), "model", NULL),3) )
}         {
}                 pci_dram_offset = 0;
}                 isa_mem_base = 0xf7000000;
}                 isa_io_base = 0xfe000000;
}                 set_config_access_method(grackle);
}         }
}
} However, I found no way in the Grackle documentation to have isa_mem_base
} at 0xf7000000. AFAIK, it's at 0xfd000000

I think I did this for the Cobra.  You can kill off the cobra.  I have two
here that I don't boot anymore for testing and I don't think many people in
the world have them.  Those that do have them aren't likely to care much
about Linux.

} Also, the grackle access method expect a PCI bridge structure configured
} with the ioremap'ed config space registers, which is not the case on
} chrp. (They are defined only in pmac_pci.c).
}
} I'm fixing those along with my changes. I suppose Grackle on CHRP uses
} memory map B ?

Actually, it seemed to use a memory map something entirely unlike A or B.

} Note (tell me if it's a problem), that I'm removing the various
} xxx_setup_pci_ptrs(). Each host bridge has a pci_controler structure (the

Good!  Thanks, those bastards have needed to die for a while.

I still do want to be able to mix-and-match PCI controllers and not have
any board<->chipset association except in the direction board->chipset but
not chipset implies board.   This helps people with custom hardware get
their boards going and helps us with new ports.

} old bridge_data) that contains also the function pointers to the access
} methods. Archs now call whatever xxx_find_bridges from their
} xxx_setup_arch() function and all host-bridge dependent setup is done there.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
