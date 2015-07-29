Return-Path: <segher@gate.crashing.org>
Date: Tue, 28 Jul 2015 22:42:21 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Thomas Huth <thuth@redhat.com>, slof@lists.ozlabs.org,
 nikunj@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [SLOF] [SLOF PATCH 2/2] fbuffer: Use a smaller cursor
Message-ID: <20150729034221.GE28839@gate.crashing.org>
References: <1438078795-14360-1-git-send-email-thuth@redhat.com>
 <1438078795-14360-3-git-send-email-thuth@redhat.com>
 <55B8430C.8060008@ozlabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55B8430C.8060008@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 29, 2015 at 01:05:48PM +1000, Alexey Kardashevskiy wrote:
> >  : fb8-toggle-cursor ( -- )
> >  	line# fb8-line2addr column# fb8-columns2bytes +
> >-	char-height 0 ?DO
> >+	char-height 3 - screen-width screen-depth * * +
> >+	3 0 ?DO
> 
> Why not just:
> 
> -	char-height 0 ?DO
> +	1 0 ?DO
> 
> ? What is this magic with screen-width about?

Thomas' patch draws the cursor as the bottom three lines of a
character cell; your suggestion would draw it as the top one line.
But indeed it could be

  char-height dup 3 - ?DO ...


Segher
