Date: Sun, 6 Aug 2000 15:06:11 +0200
From: Olaf Hering <olh@suse.de>
To: Takashi Oe <toe@unlserve.unl.edu>
Cc: David Edelsohn <dje@watson.ibm.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: a GCC question
Message-ID: <20000806150611.A4180@suse.de>
References: <200008060231.WAA22602@mal-ach.watson.ibm.com> <Pine.LNX.3.96LJ1.1b7.1000805220927.649I-100000@ofey.earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.3.96LJ1.1b7.1000805220927.649I-100000@ofey.earthlink.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Aug 05, Takashi Oe wrote:

>
> On Sat, 5 Aug 2000, David Edelsohn wrote:
>
> > 	I would guess that for smaller numbers of cases, GCC is deciding
> > that it is more efficient to use a series of "if" statements for a
> > decision tree instead of a switch statement.  You can explicitly code it
> > as such, e.g.,
> >
> > if (bi->dispDeviceDepth == 32)
> > ...
> > else if (bi-dispDeviceDepth == 16)
> > ...
> > else if
> > ...
> > else abort();
>
> Ah, that works, though the code doesn't work for some other unknown
> reasons now, probably due to something along the line of things Olaf was
> talking about recently.  Thanks!

Can you send me a diff against the current Benh kernel?
I just inserted these (useless) printk() to a non called function and
now it works so far for me.

find_pci_device_OFnode(unsigned char bus, unsigned char dev_fn)
{
/*      char blubber[60] = ""; */
        struct device_node* np;
        unsigned int *reg;
        int l;
/*      printk("I am just a dummy ...\n");  */
        for (np = allnodes; np != 0; np = np->allnext) {
                int in_macio = 0;
                struct device_node* parent = np->parent;
                while(parent) {
                        char *pname = (char *)get_property(parent, "name", &l);
        printk("I am just another dummy ...\n");
        printk("I am just another dummy ...\n");
                        if (pname && strcmp(pname, "mac-io") == 0) {
                                in_macio = 1;
                                break;
                        }

Bit ugly.


Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
