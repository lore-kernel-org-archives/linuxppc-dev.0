Return-Path: <padmanabha@tesbv.com>
Received: from hermes.tesbv.com (hermes.tesbv.com [213.215.41.187])
	by ozlabs.org (Postfix) with ESMTP id EE070DDF15
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Jan 2008 21:10:14 +1100 (EST)
Received: from athos.tesbv.com (unknown [192.168.50.10])
	by hermes.tesbv.com (Postfix) with ESMTP id 7F0D9F43A9
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Jan 2008 11:15:01 +0100 (CET)
Received: from [10.20.0.64] (unknown [10.20.0.64])
	by athos.tesbv.com (Postfix) with ESMTP id ED85C400A
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Jan 2008 11:10:03 +0100 (CET)
Message-ID: <47834C13.7030303@tesbv.com>
Date: Tue, 08 Jan 2008 15:40:27 +0530
From: padmanabha <padmanabha@tesbv.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: PPC4xx : Failed to perform memory to memory DMA
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I  am using 2.6.23  kernel for ppc 440spe based board. When i tried 
memory to memory DMA  ( please find  the code given below )
DMA is not happening.

I am trying the same for last few days.... without any success.  Can any 
one guide me.

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 


#include<linux/kernel.h>
#include<linux/module.h>
#include<linux/delay.h>

#include<asm/ppc4xx_dma.h>
#include<asm/io.h>
#include<linux/slab.h>

MODULE_LICENSE("GPL");
MODULE_DESCRIPTION("PPC4xx Mem to Mem DMA  demo");
MODULE_AUTHOR("padmanabha@tesbv.com");

extern void flush_dcache_all(void);

#define DMA_CHANNEL_NUM                         0
#define SIZE                                                    4096

ppc_dma_ch_t  ppc_dma_channel;
ppc_dma_ch_t p_init;

void * vir_dst_addr;
void * vir_src_addr;

unsigned long int  phy_src;
unsigned long int  phy_dst;

int ret, offset;

void dma_trns(void)
{

    memset( (char *)&p_init, 0, sizeof(p_init));

    p_init.polarity = 0;
    p_init.pwidth   = PW_8;

    ret = ppc4xx_init_dma_channel( DMA_CHANNEL_NUM, &p_init);

    if (ret  ==   DMA_STATUS_GOOD)
    {
        printk("%s: init_dma_channel return %d, dest is 
%p\n",__FUNCTION__, ret, vir_dst_addr);
    }

    else if(ret  ==   DMA_STATUS_BAD_CHANNEL)
    {

      printk("TS2: bad channel \n");

    }

    flush_dcache_all();

    ppc4xx_clr_dma_status( DMA_CHANNEL_NUM);

    ppc4xx_set_dma_mode(DMA_CHANNEL_NUM,DMA_MODE_MM);
    ppc4xx_set_src_addr( DMA_CHANNEL_NUM, (phys_addr_t) phy_src);
    ppc4xx_set_dst_addr(DMA_CHANNEL_NUM,  (phys_addr_t) phy_dst);
    ppc4xx_set_dma_count(DMA_CHANNEL_NUM,(SIZE * 2 ));

    ppc4xx_set_channel_priority(DMA_CHANNEL_NUM,PRIORITY_HIGH);

    ppc4xx_enable_dma(DMA_CHANNEL_NUM);


    // wait till completion of DMA


     while( 1)
     {
          mdelay(100);

          ret = 1;
          ret = ppc4xx_get_dma_residue( DMA_CHANNEL_NUM);

          if( ret == 0)
          {
              printk(" no dma operation is pending\n");
              break;
          }

     }

   ppc4xx_disable_dma( DMA_CHANNEL_NUM);

  return  ;
}

static int dma_test_init(void)
{

  vir_src_addr = (void *) __get_free_pages(GFP_KERNEL | GFP_DMA, 1);

  if( vir_src_addr == NULL )
  {
      printk( " Memory not allocated\n");
      return 1;
  }
  printk("%s: virtual address for src buffer is 0x%p \n",__FUNCTION__, 
(unsigned int *)vir_src_addr);
  memset( (unsigned long *)vir_src_addr, 0x55, sizeof(unsigned long) * 
(SIZE *2));

#if SRC_DISPLAY

  ret = 0;

  while(ret < 100)
  {

      printk( "%s: value at virtual addr 0x%p is 0x%X \n", 
__FUNCTION__,( (unsigned int *)vir_src_addr + ret ),\

      *( (unsigned int *)vir_src_addr + ret));

      ret++;

  }

#endif

  vir_dst_addr = (void *) __get_free_pages(GFP_KERNEL | GFP_DMA,1);

  if( vir_dst_addr == NULL )
  {
      printk( " Memory not allocated\n");
      free_pages( (unsigned long)vir_src_addr, 1);
      return 1;
  }
  printk("%s: virtual address for dst buffer is 0x%p 
\n",__FUNCTION__,(unsigned int *)vir_dst_addr);
  memset( (unsigned long *)vir_dst_addr, 0, sizeof(unsigned long) * 
(SIZE *2));

#if DST_DISPLAY

  ret = 0;
  while(ret < 100)
  {

      printk( "%s: value at virtual addr 0x%p is 0x%X \n", 
__FUNCTION__,( (unsigned int *)vir_dst_addr + ret ),\
      *( (unsigned int *)vir_dst_addr + ret));

      ret++;

  }
#endif

//      phy_src = virt_to_bus(vir_src_addr);
//      phy_dst = virt_to_bus(vir_dst_addr);

    phy_src = iopa( (unsigned long ) vir_src_addr);
    phy_dst =  iopa(  (unsigned long )vir_dst_addr);

  dma_trns();

    ret = 1;
    ret = ppc4xx_get_dma_residue( DMA_CHANNEL_NUM);
    if( ret == 0)
    {
        printk(" no dma operation is pending\n");

    }

  return 0;
}


void dma_test_exit(void)
{
    ret = ppc4xx_get_channel_config( DMA_CHANNEL_NUM, &ppc_dma_channel);

    if( ret != DMA_STATUS_GOOD )
    {
       printk("TS2: DMA STATUS  is not good \n");
    }
    else
    {
       printk("TS2:  DMA STATUS  good \n");

    }

    ret = 0;

    while(ret < 100)
    {

       printk( "%s: value at virtual addr 0x%p after dma is 0x%X \n", 
__FUNCTION__,( (unsigned int *)vir_dst_addr + ret ), \
       *( (unsigned int *)vir_dst_addr + ret)) ;

       ret++;
    }

   mdelay(100);

   free_pages( (unsigned long)vir_src_addr, 1);
   free_pages( (unsigned long)vir_dst_addr, 1);

}

module_init(dma_test_init);
module_exit(dma_test_exit);

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 


Thanks and Regards,
Padmanabha.s
