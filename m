Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/1] determine last ext3 LBA to fix wild LBA reads - v2
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Doug Maxey <dwm@enoyolf.org>
In-Reply-To: <32361.1167808666@bebe.enoyolf.org>
References: <32361.1167808666@bebe.enoyolf.org>
Content-Type: text/plain
Date: Thu, 04 Jan 2007 12:09:16 +1100
Message-Id: <1167872956.6165.172.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: yaboot-devel@ozlabs.org, Linux PowerPC List <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


>  static errcode_t linux_set_blksize (io_channel channel, int blksize)
>  {
> +     DEBUG_F("bs set to 0x%x\n", blksize);
>       channel->block_size = bs = blksize;
>       if (block_buffer) {
>  	  free(block_buffer);
> @@ -600,6 +612,11 @@ static errcode_t linux_read_blk (io_channel channel, unsigned long block, int co
>      
>       tempb = (((unsigned long long) block) *
>  	      ((unsigned long long)bs)) + (unsigned long long)doff;
> +     if (tempb > dend) {
> +	  DEBUG_F("\nSeek error on block %lx, tempb=%Lx\n", block, tempb >> 9);
> +	  return EXT2_ET_LLSEEK_FAILED;
> +     }
> +

In the case where we don't pass a "part", dend is 0 no ? We should check
this case and not apply the test...

Ben.
