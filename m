Date: Tue, 13 Jan 2004 12:46:25 +0100
To: linuxppc-dev@lists.linuxppc.org
Subject: OF properties access ?
Message-ID: <20040113114625.GA9294@iliana>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

I am a bit in doubt about how to go around of accessing the OF
properties.

There seem to be various get_properties functions available, but is
there any documentation on how they work ?

In particular, i have in OF, a /cpus/PowerPC,74x7. when doing
.properties there, i have a l2cr property (which 0x0 (0)).

In the same vein, i have a /pci@C0000000, which contains a
pci-bridge-number i would like to read (which contains 0x1 (1)).

For the l2cr thingy, i have based myself on some pmac_setup.c code which
does :

        /* Checks "l2cr-value" property in the registry */
        np = find_devices("cpus");
        if (np == 0)
                np = find_type_devices("cpu");
        if (np != 0) {
                unsigned int *l2cr = (unsigned int *)
                        get_property(np, "l2cr-value", NULL);
                if (l2cr != 0) {
                        seq_printf(m, "l2cr override\t: 0x%x\n", *l2cr);
                }
        }

But, the pmac OF (at least on the powerbook i got someone to check for
me), does have a l2cr property, not a l2cr-value one. The same goes on
for voltaire.debian.org, which is a dual G4 500MHz.

Does this mean that the -value appended is for looking at the content of
l2cr, or something such ?

Friendly,

Sven Luther


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
