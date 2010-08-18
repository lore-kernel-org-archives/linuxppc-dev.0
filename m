Return-Path: <dceravigupta@gmail.com>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) by ozlabs.org (Postfix) with ESMTP id 3D577B6F11
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 18 Aug 2010 22:45:04 +1000 (EST)
Received: by pzk5 with SMTP id 5so261249pzk.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 18 Aug 2010 05:45:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100813131618.GA25414@oksana.dev.rtsoft.ru>
References: <AANLkTinYCfFJB2NR3hcQ4aZU7QXfCs2ixdEu7VuNxf0=@mail.gmail.com>
	<AANLkTimJ1+d7U2SN_SSHepo6u01RJqUEXUDQXUgBfCWK@mail.gmail.com>
	<20100811164527.GA19793@oksana.dev.rtsoft.ru>
	<AANLkTi=H1sKaGL8cHm9LAZm1tzm88dvkReXk12hmkWLj@mail.gmail.com>
	<20100813131618.GA25414@oksana.dev.rtsoft.ru>
Date: Wed, 18 Aug 2010 18:15:02 +0530
Message-ID: <AANLkTinca1PuC9uDPhOPg8OWJeGJz5pHcgv8dZbV6O-L@mail.gmail.com>
Subject: Re: How to use mpc8xxx_gpio.c device driver
From: Ravi Gupta <dceravigupta@gmail.com>
To: Anton Vorontsov <cbouatmailru@gmail.com>,
	"Ira W. Snyder" <iws@ovro.caltech.edu>, MJ embd <mj.embd@gmail.com>
Content-Type: multipart/alternative; boundary=0016364585e82eea39048e186f38
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0016364585e82eea39048e186f38
Content-Type: text/plain; charset=ISO-8859-1

Hi,

Thanks for all your replies. Now I want to enable interrupts on some GPIO
pins(GPIO pins number 224, 225, 226, 227, 228 and 229 i.e gpiochip224's pins
0 to 5). I configured these pins as input(GPIOF_IN) during gpio request. I
am able to request gpio pins successfully.

#define GPIO_CHIP0_BASE    192
#define GPIO_CHIP0_COUNT   32

#define GPIO_CHIP1_BASE    224
#define GPIO_CHIP1_COUNT   32

#define GPIO(chip, pin) (GPIO_CHIP##chip##_BASE + (pin))

/* Initial GPIO pins setting. */
static struct gpio gpio_pins[] = {
  { GPIO(1,  0), GPIOF_IN,            "Chip 1, Pin 0"  },
  { GPIO(1,  1), GPIOF_IN,            "Chip 1, Pin 1"  },
  { GPIO(1,  2), GPIOF_IN,            "Chip 1, Pin 2"  },
  { GPIO(1,  3), GPIOF_IN,            "Chip 1, Pin 3"  },
  { GPIO(1,  4), GPIOF_IN,            "Chip 1, Pin 4"  },
  { GPIO(1,  5), GPIOF_IN,            "Chip 1, Pin 5"  },
};

static __init int gpio_module_init(void)
{
  int err;
  dev_t devno = 0;

  printk(KERN_INFO "GPIO Driver Version 0.1\n");

  /* resuest the gpio pin */
  err = gpio_request_array(gpio_pins, ARRAY_SIZE(gpio_pins));
  if (err) {
      printk(KERN_WARNING "gpio: unable to request gpio pins\n");
      return -EBUSY;
  }

  /* register interrupts handlers */
  err = gpio_request_irq_array(gpio_irq_pins, ARRAY_SIZE(gpio_irq_pins));
  if (err) {
      printk(KERN_WARNING "gpio: unable to register interrupt handler.\n");
      goto interrupt_fail;
  }
.
.
.
}

Now in order to enable interrupts I have to set the bits corresponding to
these pins in gpiochp Interrupt Mask Register.

My first question is that is there any gpio API call available for doing
this? OR I have to manually memory map the gpio IMR register and set bit
manually? For the time being I have manually set the IMR bit(using memory
map).

Second, in order to register an interrupt handler on a gpio pin, I need a
IRQ number, so how am I going to get that number? From the
Documentation/gpio.txt, it looks to me that gpio_to_irq() function should
give me the irq number, but when I tried to use it, it gives me an error.

#define GPIO_CHIP0_BASE    192
#define GPIO_CHIP0_COUNT   32

#define GPIO_CHIP1_BASE    224
#define GPIO_CHIP1_COUNT   32

#define GPIO(chip, pin) (GPIO_CHIP##chip##_BASE + (pin))

static struct gpio_irq gpio_irq_pins[] = {
  { GPIO(1, 0), IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW },
  { GPIO(1, 1), IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW },
  { GPIO(1, 2), IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW },
  { GPIO(1, 3), IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW },
  { GPIO(1, 4), IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW },
  { GPIO(1, 5), IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW },
};

int gpio_request_irq_array(struct gpio_irq *array, size_t num)
{
  int i, err, irq;

  for (i = 0; i < num; i++, array++) {
    /* get the irq number corresponding to the gpio pin */
    irq = gpio_to_irq(array->gpio);
    if (irq < 0) {
      printk(KERN_ERR "gpio: Trying to get irq number for GPIO%d\n",
array->gpio);
      err = -EINVAL;
      goto err_free;
    }
    printd("gpio: irq number for GPIO%d = %d(i=%d)\n", array->gpio, irq, i);


    /* set the irq type for the gpio pin */
    err = set_irq_type(irq, array->type);
    if (err)
      goto err_free;

    /* register irq handler */
    err = request_irq(irq, gpio_irq_handler, IRQF_SHARED, "GPIO Driver",
NULL);
    if (err) {
      printk(KERN_ERR "gpio: can't get assigned irq for GPIO%d\n",
array->gpio);
      goto err_free;
    }
  }
  return 0;

err_free:
  while (i--)
    free_irq(gpio_to_irq((--array)->gpio), NULL);
  return err;
}

Given above is my driver code, I have implemented a function named
"gpio_request_irq_array" which works in same manner as that of
"gpio_request_array". I am calling in the init function, see the init code
given initially. Now when I load it on my MPC837xERDB board, it gives the
following errors.

[ 1812.776420] GPIO Driver Version 0.1
[ 1812.779985] gpio: Trying to get irq number for GPIO224
[ 1812.785126] gpio: unable to register interrupt handler.
insmod: error inserting './gpio.ko': -1 Invalid parameters

Thanks in advance
Ravi Gupta

--0016364585e82eea39048e186f38
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>Thanks for all your replies. Now I want to enable interrupts on =
some GPIO pins(GPIO pins number 224, 225, 226, 227, 228 and 229 i.e gpiochi=
p224&#39;s pins 0 to 5). I configured these pins as input(GPIOF_IN) during =
gpio request. I am able to request gpio pins successfully.<br>
<br>#define GPIO_CHIP0_BASE=A0=A0=A0 192<br>#define GPIO_CHIP0_COUNT=A0=A0 =
32<br><br>#define GPIO_CHIP1_BASE=A0=A0=A0 224<br>#define GPIO_CHIP1_COUNT=
=A0=A0 32<br><br>#define GPIO(chip, pin) (GPIO_CHIP##chip##_BASE + (pin))<b=
r><br>/* Initial GPIO pins setting. */<br>
static struct gpio gpio_pins[] =3D { <br>=A0 { GPIO(1,=A0 0), GPIOF_IN,=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &quot;Chip 1, Pin 0&quot;=A0 },<br>=A0 { GPI=
O(1,=A0 1), GPIOF_IN,=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &quot;Chip 1, Pin 1&=
quot;=A0 },<br>=A0 { GPIO(1,=A0 2), GPIOF_IN,=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 &quot;Chip 1, Pin 2&quot;=A0 },<br>
=A0 { GPIO(1,=A0 3), GPIOF_IN,=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &quot;Chip =
1, Pin 3&quot;=A0 },<br>=A0 { GPIO(1,=A0 4), GPIOF_IN,=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 &quot;Chip 1, Pin 4&quot;=A0 },<br>=A0 { GPIO(1,=A0 5), GPIOF_=
IN,=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &quot;Chip 1, Pin 5&quot;=A0 },<br>};<=
br><br>
static __init int gpio_module_init(void)<br>{<br>=A0 int err;<br>=A0 dev_t =
devno =3D 0;<br><br>=A0 printk(KERN_INFO &quot;GPIO Driver Version 0.1\n&qu=
ot;);<br><br>=A0 /* resuest the gpio pin */<br>=A0 err =3D gpio_request_arr=
ay(gpio_pins, ARRAY_SIZE(gpio_pins));<br>
=A0 if (err) {<br>=A0=A0=A0=A0=A0 printk(KERN_WARNING &quot;gpio: unable to=
 request gpio pins\n&quot;);<br>=A0=A0=A0=A0=A0 return -EBUSY;<br>=A0 }<br>=
<br>=A0 /* register interrupts handlers */<br>=A0 err =3D gpio_request_irq_=
array(gpio_irq_pins, ARRAY_SIZE(gpio_irq_pins));<br>
=A0 if (err) {<br>=A0=A0=A0=A0=A0 printk(KERN_WARNING &quot;gpio: unable to=
 register interrupt handler.\n&quot;);<br>=A0=A0=A0=A0=A0 goto interrupt_fa=
il;<br>=A0 }<br>.<br>.<br>.<br>}<br><br>Now in order to enable interrupts I=
 have to set the bits corresponding to these pins in gpiochp Interrupt Mask=
 Register. <br>
<br>My first question is that is there any gpio API call available for doin=
g this? OR I have to manually memory map the gpio IMR register and set bit =
manually? For the time being I have manually set the IMR bit(using memory m=
ap). <br>
<br>Second, in order to register an interrupt handler on a gpio pin, I need=
 a IRQ number, so how am I going to get that number? From the Documentation=
/gpio.txt, it looks to me that gpio_to_irq() function should give me the ir=
q number, but when I tried to use it, it gives me an error.<br>
<br>#define GPIO_CHIP0_BASE=A0=A0=A0 192<br>
#define GPIO_CHIP0_COUNT=A0=A0 32<br>
<br>
#define GPIO_CHIP1_BASE=A0=A0=A0 224<br>
#define GPIO_CHIP1_COUNT=A0=A0 32<br>
<br>
#define GPIO(chip, pin) (GPIO_CHIP##chip##_BASE + (pin))<br><br>static stru=
ct gpio_irq gpio_irq_pins[] =3D {<br>=A0 { GPIO(1, 0), IRQ_TYPE_LEVEL_HIGH =
| IRQ_TYPE_LEVEL_LOW },<br>=A0 { GPIO(1, 1), IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE=
_LEVEL_LOW },<br>
=A0 { GPIO(1, 2), IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW },<br>=A0 { GPIO=
(1, 3), IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW },<br>=A0 { GPIO(1, 4), IR=
Q_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW },<br>=A0 { GPIO(1, 5), IRQ_TYPE_LEV=
EL_HIGH | IRQ_TYPE_LEVEL_LOW },<br>
};<br><br>int gpio_request_irq_array(struct gpio_irq *array, size_t num)<br=
>{<br>=A0 int i, err, irq;<br><br>=A0 for (i =3D 0; i &lt; num; i++, array+=
+) {<br>=A0=A0=A0 /* get the irq number corresponding to the gpio pin */<br=
>=A0=A0=A0 irq =3D gpio_to_irq(array-&gt;gpio);<br>
=A0=A0=A0 if (irq &lt; 0) {<br>=A0=A0=A0=A0=A0 printk(KERN_ERR &quot;gpio: =
Trying to get irq number for GPIO%d\n&quot;, array-&gt;gpio);<br>=A0=A0=A0=
=A0=A0 err =3D -EINVAL;<br>=A0=A0=A0=A0=A0 goto err_free;<br>=A0=A0=A0 }=A0=
=A0 <br>=A0=A0=A0 printd(&quot;gpio: irq number for GPIO%d =3D %d(i=3D%d)\n=
&quot;, array-&gt;gpio, irq, i); <br>
<br>=A0=A0=A0 /* set the irq type for the gpio pin */<br>=A0=A0=A0 err =3D =
set_irq_type(irq, array-&gt;type);<br>=A0=A0=A0 if (err)<br>=A0=A0=A0=A0=A0=
 goto err_free;<br><br>=A0=A0=A0 /* register irq handler */<br>=A0=A0=A0 er=
r =3D request_irq(irq, gpio_irq_handler, IRQF_SHARED, &quot;GPIO Driver&quo=
t;, NULL);<br>
=A0=A0=A0 if (err) {<br>=A0=A0=A0=A0=A0 printk(KERN_ERR &quot;gpio: can&#39=
;t get assigned irq for GPIO%d\n&quot;, array-&gt;gpio);<br>=A0=A0=A0=A0=A0=
 goto err_free;<br>=A0=A0=A0 }=A0=A0 <br>=A0 }<br>=A0 return 0;<br><br>err_=
free:<br>=A0 while (i--)<br>=A0=A0=A0 free_irq(gpio_to_irq((--array)-&gt;gp=
io), NULL);<br>
=A0 return err;<br>}<br><br>Given above is my driver code, I have implement=
ed a function named=20
&quot;gpio_request_irq_array&quot; which works in same manner as that of=20
&quot;gpio_request_array&quot;. I am calling in the init function, see the =
init=20
code given initially. Now when I load it on my MPC837xERDB board, it gives =
the following errors.<br><br>[ 1812.776420] GPIO Driver Version 0.1<br>[ 18=
12.779985] gpio: Trying to get irq number for GPIO224<br>[ 1812.785126] gpi=
o: unable to register interrupt handler.<br>
insmod: error inserting &#39;./gpio.ko&#39;: -1 Invalid parameters<br><br>T=
hanks in advance<br>Ravi Gupta<br>

--0016364585e82eea39048e186f38--
