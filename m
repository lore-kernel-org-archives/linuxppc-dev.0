Return-Path: <ebs@ebshome.net>
Date: Wed, 9 Feb 2005 09:11:49 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Marco Schramel <Schramel.Linux@go.bartec.de>
Message-ID: <20050209171149.GA10316@gate.ebshome.net>
References: <200502091710.25227.Schramel.Linux@go.bartec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200502091710.25227.Schramel.Linux@go.bartec.de>
Cc: Linuxppc-embedded@ozlabs.org
Subject: Re: true ide
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Feb 09, 2005 at 05:10:25PM +0100, Marco Schramel wrote:
> on my custom board i can access my compact flash card through true ide interface. My UPM's work und the taskfile is ready to use.
> How i tell my kernel (denx 2.4.25) to use my taskfile for ide access?
> How can i register the compact flash as hard drive in linux ??

Here is an example code for CF attached to the external bus on PPC4xx:

---------------------------------------------------------------------
static void cf_ide_insw(unsigned long port, void *addr, u32 count){
    _insw((volatile u16*)port, addr, count);
}

static void cf_ide_outsw(unsigned long port, void *addr, u32 count){
    _outsw((volatile u16*)port, addr, count);
}

void __init cf_ide_probe(void){

	/* Find an empty slot */
	while (idx < MAX_HWIFS && ide_hwifs[idx].io_ports[IDE_DATA_OFFSET])
		++idx;

	if (idx == MAX_HWIFS){
		printk(KERN_ERR"Cannot find empty IDE hwif slot\n");
                return;
        }

	hwif = &ide_hwifs[idx];
        hw = &hwif->hw;
        hw->io_ports[IDE_DATA_OFFSET]    = cf_taskfile_main_kva;
        hw->io_ports[IDE_ERROR_OFFSET]   = cf_taskfile_main_kva + 3;
        hw->io_ports[IDE_NSECTOR_OFFSET] = cf_taskfile_main_kva + 5;
        hw->io_ports[IDE_SECTOR_OFFSET]  = cf_taskfile_main_kva + 7;
        hw->io_ports[IDE_LCYL_OFFSET]    = cf_taskfile_main_kva + 9;
        hw->io_ports[IDE_HCYL_OFFSET]    = cf_taskfile_main_kva + 0xb;
        hw->io_ports[IDE_SELECT_OFFSET]  = cf_taskfile_main_kva + 0xd;
        hw->io_ports[IDE_STATUS_OFFSET]  = cf_taskfile_main_kva + 0xf;
        hw->io_ports[IDE_CONTROL_OFFSET] = cf_taskfile_alt_kva + 0xd;
        memcpy(hwif->io_ports, hw->io_ports, sizeof(hwif->io_ports));
        hwif->irq = hw->irq = CF_IRQ;
        hwif->noprobe = 0;

        /* Don't probe second drive */
        hwif->drives[1].noprobe = 1;

        default_hwif_mmiops(hwif);

        /* Override 16-bit string ops to do byte-swapping */
        hwif->OUTSW = cf_ide_outsw;
        hwif->INSW = cf_ide_insw;
}
-------------------------------------------------------------------

Some comments: cf_task_main_kva - ioremmaped main taskfile (main chip 
select), cf_task_file_atl_kva - ioremapped alternative taskfile 
(second chip select). In my case board support code sets up those. 
CF_IRQ - interrupt request from CF.

Also, note that actual offset for each taskfile register depends on 
how you wired CF to the CPU, it may be different in your case, so use 
this code as an _example_.

I call cf_ide_probe() from drivers/ide/ide.c::probe_for_hwifs.

--
Eugene
